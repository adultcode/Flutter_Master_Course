import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Box.dart';
void main(){
  runApp(
      ProviderScope(child: MaterialApp(
        home: MyApp(),
      ))
  );
}
class MyApp extends StatefulWidget {

  var Section = List.generate(3, (i) => List<Box>.filled(3,Box()), growable: false);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

/*
    0  |  1  |  2
    -------------
    3  |  4  |  5
    -------------
    6  |  7  |  8


 */

  var turn = 0;
  var winner = "";
  var finish = 0;
  var boxes = List<Box>.filled(9, Box(isempty: true),growable: false);

  void ChangeTurn(){
    if(turn==0){
      turn =1;
    }else{
      turn = 0;
    }
  }

  Widget BoxComponent(int index){
    return InkWell(
      onTap: (){
        if(boxes[index].isempty == true && finish==0){
         var bx = Box(owner: turn,isempty: false);
         boxes[index] = bx;
          //boxes[index].owner = turn;
          ChangeTurn();
          setState(() {

          });
          CheckVictor();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        alignment: Alignment.center,
        color: Colors.white,
        child: XO(boxes[index].owner),
      ),
    );
  }

  void CheckVictor(){

    // row 1
    if(boxes[0].owner== boxes[1].owner && boxes[0].owner==boxes[2].owner
    && boxes[0].isempty== false){
      setState(() {
        winner = "Winner: Player ${boxes[0].owner}";
        finish = 1;
      });
    }

    // row 2
   else if(boxes[3].owner== boxes[4].owner && boxes[3].owner==boxes[5].owner
        && boxes[3].isempty== false){
      setState(() {
        winner = "Winner: Player ${boxes[3].owner}";
        finish = 1;
      });
    }
   // row 3
    else if(boxes[6].owner== boxes[7].owner && boxes[6].owner==boxes[8].owner
        && boxes[6].isempty== false){
      setState(() {
        winner = "Winner: Player ${boxes[6].owner}";
        finish = 1;
      });
    }
    // column 1
    else if(boxes[0].owner== boxes[3].owner && boxes[0].owner==boxes[6].owner
        && boxes[0].isempty== false){
      setState(() {
        winner = "Winner: Player ${boxes[0].owner}";
        finish = 1;
      });
    }
    // Column 2
    else if(boxes[1].owner== boxes[4].owner && boxes[1].owner==boxes[7].owner
        && boxes[1].isempty== false){
      setState(() {
        winner = "Winner: Player ${boxes[1].owner}";
        finish = 1;
      });
    }
    // Column 3
    else if(boxes[2].owner== boxes[5].owner && boxes[2].owner==boxes[8].owner
        && boxes[2].isempty== false){
      setState(() {
        winner = "Winner: Player ${boxes[2].owner}";
        finish = 1;
      });
    }

  }
Widget XO(var player){

    if(player==1){
      return Text("O",style: TextStyle(fontSize: 27.0,fontWeight: FontWeight.bold,
      color: Colors.black),);
    }
    else if(player==0){
      return Text("X",style: TextStyle(fontSize: 27.0,fontWeight: FontWeight.bold,
          color: Colors.red),);
    }else{
      return Text("");
    }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  color: Colors.grey,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 3/3,
                        maxCrossAxisExtent: 150.0,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5
                      ),
                      itemCount: 9,
                      itemBuilder: (context,index){
                        return BoxComponent(index);
                      }),
                ),
                Text(winner,style: TextStyle(fontSize: 25.0,color: Colors.white,
                    fontWeight: FontWeight.bold),)
              ],
            )
          )
        )

    );
  }
}



