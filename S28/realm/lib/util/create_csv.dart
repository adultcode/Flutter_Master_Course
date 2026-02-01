import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:realm_todo/model/post_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
class CreateCSV{


  BuildContext buildContext;

  CreateCSV(this.buildContext);

 // List<List<String>>
  List<String> PostToCSV(PostModel postModel){

    return [   postModel.title!,postModel.content!,postModel.category!,
              postModel.date!];
  }

  /*
  request permission
   */

Future<void> requestStoragePermission()async{
  var status = await Permission.manageExternalStorage.request();

  if(status.isGranted){
    print("storage permission granted");
  }else if(status.isDenied){
    await openAppSettings();
    print("storage permission isDenied");

  }else if(status.isPermanentlyDenied){
    await openAppSettings();
    print("storage permission isPermanentlyDenied");
  }
}

  void CreateCSVFile(List<PostModel> postlist)async{

    var status = await Permission.manageExternalStorage.status;
    if(status.isGranted){
     try{
       List<List<String>> csvData = postlist.map((e) => PostToCSV(e)).toList();


       String csvString = ListToCsvConverter().convert(csvData);

       final directory = await getApplicationDocumentsDirectory();

       Directory generalDownload = Directory('/storage/emulated/0/Download');
       final path = generalDownload.path+"/posts.csv";
       final file = File(path);
       file.writeAsStringSync(csvString);
       print("----file created---");
     }catch(e){
       print("Error: ${e.toString()}");
     }




    }else{
      // no permission
      requestStoragePermission();
    }
  }






}