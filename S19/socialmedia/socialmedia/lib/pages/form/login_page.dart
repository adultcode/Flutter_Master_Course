import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socialmedia/state/login_state.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/screen_size.dart';
import 'package:socialmedia/widgets/sign_form_input.dart';

import '../../bloc/login_cubit.dart';

class LoginPage extends StatefulWidget {
  final  LoginCallBack? loginCallBack;


  LoginPage(this.loginCallBack);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _email_controller = TextEditingController();
  var _password_controller = TextEditingController();
  LoginCubit? _cubit;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = LoginCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenSize.width*100,
      height: ScreenSize.height*100,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: ScreenSize.height*7,),
                Text("خوش آمدید",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w600),),
                SizedBox(height: ScreenSize.height*5,),
                SignFormInput('ایمل', _email_controller,
                    Icon(Icons.alternate_email_outlined),
                    false),
                SizedBox(height: ScreenSize.height*5,),
                SignFormInput('رمز عبور', _password_controller,
                    Icon(Icons.lock_outline),
                    true),
                SizedBox(height: ScreenSize.height*7,),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.title_black,
                      minimumSize: const Size.fromHeight(50.0),
                    ),
                onPressed: ()async{

                      if(_email_controller.text.isNotEmpty || _password_controller.text.isNotEmpty){
                        var _fromdata={
                          "username": _email_controller.text,
                          "password": _password_controller.text
                        };

                        _cubit?.SendRequest(_fromdata);
                        print("formdata: ${_fromdata.toString()}");
                      }


                },

                    child: Text("وارد شوید",style: TextStyle(fontSize: 18),)),



                SizedBox(height: ScreenSize.height*3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: widget.loginCallBack,
                      child: Text("ساخت حساب",style: TextStyle(fontWeight: FontWeight.w600,
                      fontSize: 16,color: MyColor.app_blue),),
                    ),
                    SizedBox(width: 10.0,),
                    Text("حساب کاربری ندارید؟",style: TextStyle(fontSize: 16,),)
                  ],
                ),
                SizedBox(height: ScreenSize.height*3,),

                BlocBuilder<LoginCubit,LoginState>(
                  bloc: _cubit,
                  builder: (context, state){
                    if(state is ErrorState){
                      return Center(
                        child: Text(state.data,style: TextStyle(fontSize: 18.0,color: Colors.red),),
                      );
                    }else if(state is LoadingState){
                      return Container(child:  CircularProgressIndicator(),);
                    } else if (state is SuccessState){
                      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                        print("Called callback");
                        context.goNamed('timeline');
                      });
                      return Text("Welcome ${state.data.email}");

                    }else{
                      return Container();
                    }
                  },
                )
              ],
            ),
      ),
    );
  }
}

typedef LoginCallBack = void Function();