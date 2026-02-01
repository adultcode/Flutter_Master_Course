import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/repository/edit_profile_repository.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/my_string.dart';
import 'package:socialmedia/util/screen_size.dart';
import 'package:socialmedia/util/user_instance.dart';

import '../util/global_key.dart';
import '../util/myURL.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  var bio_controller = TextEditingController();
  var name_controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  EditProfileRepository? _editProfileRepository;
  File? _file;
  String img = "null";
  String status="";


  @override
  void initState() {
    // TODO: implement initState
    bio_controller.text = UserInstance.userModel!.bio.toString();
    name_controller.text = UserInstance.userModel!.name.toString();

    _editProfileRepository = EditProfileRepository();
    EditProfileRepository.streamController.stream.listen((event) {

      if(event=="done"){
        status = MyString.edit_profile_done;
        print("Stream done");
      }else{
        status = MyString.error_400;
        print("Stream Error");
      }
      var snackBar = SnackBar(content: Text(status),backgroundColor: Colors.cyanAccent,);
      ScaffoldMessenger.of(GlobalKeyVariable.rootScaffoledEditKey.currentContext!).showSnackBar(snackBar);
    });
  }

  Future<String> ImageToBase64(var img_file)async{
    final imageBytes = await img_file.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    return base64Image;
  }

  ImageProvider ShowImage(var file){
    if(file!=null){
      return FileImage(file);
    }else{
      return NetworkImage("${Urls.media}${UserInstance.userModel?.avatar}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: GlobalKeyVariable.rootScaffoledEditKey,
      appBar: AppBar(
        title: Text("ویرایش اطلاعات"),
      ),
      body: Container(
        width: ScreenSize.width*100,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width*4,vertical: ScreenSize.height*2),
          child: ListView(
            children: [
              Container(width: ScreenSize.width*100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(onPressed: ()async{
                    XFile? _xfile = await _picker.pickImage(source: ImageSource.gallery);
                    if(_xfile!=null){
                      img = await ImageToBase64(File(_xfile.path));
                      setState(() {
                        _file = File(_xfile.path);
                      });
                    }else{
                      img = "null";
                      setState(() {
                        _file = null;
                      });
                    }
                  },

                      child: Text("انتخاب تصویر")
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                    width: ScreenSize.width*18,
                    height: ScreenSize.width*18,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3)
                        )
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: ShowImage(_file),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ],

              ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenSize.height*2),
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: MyColor.input_border,
                    width: 1.3
                  )
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  controller: name_controller,
                  style: TextStyle(fontSize: 17.0,color: MyColor.title_black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "نام اکانت",
                    hintStyle: TextStyle(fontSize: 17.0,color: MyColor.input_border)
                  ),
                ),
              ), Container(
                margin: EdgeInsets.symmetric(vertical: ScreenSize.height*2),
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        color: MyColor.input_border,
                        width: 1.3
                    )
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  controller: bio_controller,
                  style: TextStyle(fontSize: 17.0,color: MyColor.title_black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "بیوگرافی",
                      hintStyle: TextStyle(fontSize: 17.0,color: MyColor.input_border)
                  ),
                ),
              ),


              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: (){


                var temp;
                if(_file==null){
                  temp  = "null";
                }else{
                  temp = "data:image/png;base64,"+img;
                }


                var _formdata ={
                  "bio": bio_controller.text.toString(),
                  "name": name_controller.text.toString(),
                  "img": temp
                };
                _editProfileRepository?.EditProfile(_formdata);
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.title_black,
                    minimumSize: const Size.fromHeight(50.0)
                  ),
                  child: Text('ارسال پست',style: TextStyle(fontSize: 18),))
            ],
          ),
      ),
    );
  }
}
