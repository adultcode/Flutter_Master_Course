import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/repository/send_post_repository.dart';
import 'package:socialmedia/util/global_key.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/my_string.dart';
import 'package:socialmedia/util/screen_size.dart';


class SendPostPage extends StatefulWidget {
  const SendPostPage({Key? key}) : super(key: key);

  @override
  State<SendPostPage> createState() => _SendPostPageState();
}

class _SendPostPageState extends State<SendPostPage> {

  final ImagePicker _picker = ImagePicker();
  File? _file;
  var text_controller = TextEditingController();
  String img = "null";
  String status = "";
  String temp = "";
  SendPostRepository? _sendPostRepository;

  @override
  void initState() {
    // TODO: implement initState
    _sendPostRepository = SendPostRepository();
    SendPostRepository.streamController.stream.listen((event) {
      if(event==1){
        status = MyString.post_done;
      }else{
        status = MyString.catch_error;
      }

      var snackBar  = SnackBar(content: Text(status));

      ScaffoldMessenger.of(GlobalKeyVariable.rootScafoldPostKey.currentContext!).showSnackBar(snackBar);
    });
  }

  Widget ShowImage(var file){
    if(file!=null){
      return Image.file(file,width: ScreenSize.width*15,);
    }else{
      return Container(color: Colors.black,);
    }
  }

  Future<String> ImageToBase64(var img_file)async{
    final imageBytes = await img_file.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKeyVariable.rootScafoldPostKey,
      appBar: AppBar(
        title: Text("ارسال پست"),
      ),
      body: Container(
        width: ScreenSize.width*100,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width*4,vertical: ScreenSize.height*2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              height: ScreenSize.height*15,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: MyColor.input_border,
                  width: 1.3
                ),
              ),
              child: TextField(
                textAlign: TextAlign.right,
                controller: text_controller,
                style: TextStyle(fontSize: 17,color: MyColor.title_black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "متن مورد نظر",
                  hintStyle: TextStyle(fontSize: 17.0,color: MyColor.input_border)
                ),
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: ()async{
                        XFile? _xfile = await _picker.pickImage(source: ImageSource.gallery);

                        img = await ImageToBase64(File(_xfile!.path));
                        if(_xfile!=null){
                          setState(() {
                            _file = File(_xfile.path);
                          });
                        }else{
                          setState(() {
                            _file = null;
                          });
                        }
                      },
                      icon: Icon(Icons.image_outlined,size: ScreenSize.width*15,color: MyColor.app_blue,),

                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                    width: ScreenSize.width*15,
                    height: ScreenSize.height*12,
                    child: ShowImage(_file),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              width: ScreenSize.width*100,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.title_black,
                    minimumSize: const Size.fromRadius(20.0),


                  ),
                  onPressed: (){

                    if(img=="null"){
                      temp = "null";
                    }else{
                      temp = "data:image/png;base64,"+img;
                    }

                    var _formdata = {
                      "content": text_controller.text,
                      "img": temp
                    };
                    print(_formdata);
                   _sendPostRepository?.SendPost(_formdata);
              },
                  child: Text("ارسال پست",style: TextStyle(fontSize: 18.0),)),
            )
          ],
        ),
      ),
    );
  }
}
