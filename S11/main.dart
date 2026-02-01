import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp(),
    debugShowCheckedModeBanner: false,)
  );
}

class MyApp extends StatelessWidget {

  static var width;
  static var height;

  var black_color = Color(0xff2a2d3f);
  var grey_color = Color(0xffc4c4d5);
  var blue_color = Color(0xff7a99d7);

  List<Product> data = [];

  Widget TopIcon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.segment,size:25.0),
        Container(
          margin: EdgeInsets.only(right: 15.0),
          child:  CircleAvatar(
            child: Icon(Icons.person),
          ),
        )
      ],
    );
  }

  Widget SearchRow(){
    return Row(
      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height*0.25,horizontal: width*2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0,3)
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_rounded,size: 20.0,color: black_color,),
              Container(
                width: width*60,
                height: height*5.0,
                margin: EdgeInsets.only(left: 5.0),
                child: TextField(
                  style: TextStyle(color: black_color,fontSize: 18.0),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: grey_color,fontSize: 16.0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Stack(
            children: [
              Icon(Icons.shopping_cart_outlined,size: 35.0,),
              Container(
                width: 15.0,
                height: 15.0,
                margin: EdgeInsets.only(left: 20.0),
                child: Text('4',textAlign:TextAlign.center,style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold,
                    color: Colors.white),),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
                ),
              )
            ],
          ),
        )
      ],
    );

  }

  Widget Products(){

    data.add(Product('White sofa', "https://www.offdecor.com/image/media/postcategory/3459/01aaa%20(1).jpg", "255"));
    data.add(Product('Black sofa', "https://www.offdecor.com/image/media/postcategory/3459/01aaa%20(2).jpg", "255"));
    data.add(Product('White room', "https://www.offdecor.com/image/media/postcategory/3459/01aaa%20(3).jpg", "255"));
    return Container(

      height: height*34,
        margin: EdgeInsets.only(top: 20.0),
      child: ListView.builder(

        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.only(right: 30.0,top: 4.0,bottom: 4.0),
            width: width*42.0,
            height: height*34.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0,3)
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height*16,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    image: DecorationImage(image: NetworkImage(data[index].img),
                    fit: BoxFit.cover)
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(data[index].title,style: TextStyle(fontSize: 14.0,color: black_color,
                  fontWeight: FontWeight.bold),),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text("Description",style: TextStyle(fontSize: 12,color: grey_color),),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: height*3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${data[index].price}",style: TextStyle(
                        fontSize: 16.0,color: black_color
                      ),),

                      Container(
                        height: 25.0,
                        width: 25.0,
                        child: Icon(Icons.add,size:15.0,color: Colors.white,),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blue_color
                        ),
                      )


                    ],
                  ),
                )
              ],
            ),
          );
        },
      )
      ,

    );
  }


  Widget BestSelling(){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      margin: EdgeInsets.only(right: 15.0,top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [

          Container(
            width: width*18,
            height: width*18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(image: NetworkImage(data[0].img),
              fit: BoxFit.cover)
            ),
          ),
          SizedBox(width: 15.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data[0].title,style: TextStyle(fontSize: 14.0,color: black_color,
                  fontWeight: FontWeight.bold),),
              SizedBox(height: 8.0,),
              Text("Description",style: TextStyle(fontSize: 12.0,color: grey_color),),
              SizedBox(height: 8.0,),
              Text("\$${data[0].price}",style: TextStyle(fontSize: 15.0,color: black_color,)),
            ],
          ),
          Spacer(),
          Container(
            width: 30.0,
            height: 30.0,
            child: Icon(Icons.arrow_forward,size: 17.0,color: Colors.white,),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: blue_color
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width/100;
     height = MediaQuery.of(context).size.height/100;
    return Scaffold(

        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15.0,top: height*3),
           color: Color(0xfff5f6fa),
            width: width*100,
            height: height*100,
            child: Column(
              children: [

                TopIcon(),
                SizedBox(height: height*4,),
                SearchRow(),
                Container(
                  margin: EdgeInsets.only(top: height*4),
                  alignment: Alignment.topLeft,
                  child: Text("Explore",style: TextStyle(fontWeight: FontWeight.w600,
                  color: black_color,fontSize: 22.0),),
                ),
                Products(),
                Container(
                  margin: EdgeInsets.only(top: height*4),
                  alignment: Alignment.topLeft,
                  child: Text("Best Selling",style: TextStyle(fontWeight: FontWeight.w600,
                      color: black_color,fontSize: 22.0),),
                ),
                BestSelling()
              ],
            ),
          ),
        )

    );
  }
}


class Product{
  String title,img,price;

  Product(this.title, this.img, this.price);
}