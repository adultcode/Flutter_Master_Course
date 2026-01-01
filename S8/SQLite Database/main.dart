import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:season/DbHelper.dart';
import 'package:season/phone.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DBWidget()
    );
  }
}

class DBWidget extends StatefulWidget {
  const DBWidget({Key? key}) : super(key: key);

  @override
  _DBWidgetState createState() => _DBWidgetState();
}

class _DBWidgetState extends State<DBWidget> {

  late DBHelper _sqliteservice;
  var name_controller = TextEditingController();
  var number_controller = TextEditingController();
  TextStyle _style = TextStyle(fontSize: 20.0,color: Colors.black);
  @override
  void initState() {
    // TODO: implement initState
    _sqliteservice = DBHelper();
    _sqliteservice.initializeDB().whenComplete(() async{
      print("Database opend");
    });
  }

  void SavePhone(var name, int number) async{
    await _sqliteservice.CreateItem(Phone(name:name,number:number));

  }

  Widget ShowList(List<Phone> _list){

    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          margin: EdgeInsets.only(top:10.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_list[index].name.toString(),style: _style,),
              Text(_list[index].number.toString(),style: _style,),
              IconButton(onPressed: (){
                _sqliteservice.DeleteItem(_list[index].id!);
              },
                  icon: Icon(Icons.delete_forever,color: Colors.redAccent,))

            ],
          ),

        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){

              showDialog(context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Add contact"),
                      actions: [
                        TextButton(onPressed: (){
                          SavePhone(name_controller.text,int.parse(number_controller.text) );
                        },
                            child: Text("Save"))
                      ],
                      content: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: name_controller,
                              decoration: InputDecoration(
                                hintText: "Name"
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            TextField(
                              controller: number_controller,
                              decoration: InputDecoration(
                                hintText: "Number"
                              ),
                            ),
                            SizedBox(height: 20.0,),
                          ],
                        ),
                      ),
                    );
                  }
              );



            },


            icon: Icon(Icons.add_circle_outlined),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _sqliteservice.GetData(),
          builder: (context,AsyncSnapshot<dynamic> snapshot ){

            if(snapshot.hasData){
              return ShowList(snapshot.data);
            }else{
              return Center(
                child: Text("Loading..."),
              );
            }
          },
        ),
      ),
    );
  }
}


