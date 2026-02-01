import 'package:flutter/material.dart';
import 'package:realm_todo/model/category_model.dart';
import 'package:realm_todo/model/post_model.dart';
import 'package:realm_todo/provider/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:realm_todo/provider/post_provider.dart';
import 'package:realm_todo/util/create_csv.dart';
import 'package:realm_todo/util/my_color.dart';
import 'package:realm_todo/widget/category_item.dart';
import 'package:realm_todo/widget/post_item.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
        MultiProvider(providers:[
          ChangeNotifierProvider(create: (context) => CategoryProvider(),),
          ChangeNotifierProvider(create: (context) => PostProvider(),),

        ],
        child: MyApp(),
        ) ,

  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      title: 'Flutter Demo',

      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _category_controller = TextEditingController();
  TextEditingController _title_controller = TextEditingController();
  TextEditingController _content_controller = TextEditingController();
  String selected_category = "";
  String date_format = "";
  late DateTime dateTime;

  var current_category;

  /*
  create category
   */
  void CreateCategory({CategoryModel? categoryModel}){

    if(categoryModel!=null){

      _category_controller.text = categoryModel.title!;
    }

    showModalBottomSheet(context: context, builder: (context) {

      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 25,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New Category",
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w400
                  ,color: Colors.black87 ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1,color: Colors.black87)
              ),
              child: TextField(
                controller: _category_controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 40,),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [

               // add button
               ElevatedButton(

                   style: ElevatedButton.styleFrom(
                       backgroundColor: MyColor.main_color
                   ),
                   onPressed: () {

                     if(categoryModel==null){
                       /*
                  create new category
                   */
                       CategoryModel cat = CategoryModel(0,title: _category_controller.text);
                       var result =  Provider.of<CategoryProvider>(context,listen: false).InsertCategory(cat);
                       if(result){
                         Navigator.pop(context);
                       }else{
                         print("Errorrr");
                       }
                     }
                     else{
                       /*
                  update category
                   */
                       var result =  Provider.of<CategoryProvider>(context,listen: false)
                           .UpdateCategory(categoryModel, _category_controller.text);
                       if(result){
                         Navigator.pop(context);
                       }else{
                         print("Errorrr");
                       }

                     }



                   }, child: Text("Add",style: TextStyle(color: Colors.white),)),

               // remove item
               ElevatedButton(

                   style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.red
                   ),
                   onPressed: () {

                     if(categoryModel==null){
                       /*
                  clear textfield
                   */
                       _category_controller.clear();

                     }
                     else{
                       /*
                  update category
                   */
                       var result =  Provider.of<CategoryProvider>(context,listen: false)
                           .DeleteCategory(categoryModel);
                       if(result){
                         Navigator.pop(context);
                       }else{
                         print("Errorrr");
                       }

                     }



                   }, child: Text("Remove",style: TextStyle(color: Colors.white),))
             ],
           )
          ],
        ),
      );

    },);
  }

/*
create pos
 */
  void CreatePost(){

      _title_controller.clear();
      _content_controller.clear();


    showModalBottomSheet(context: context, builder: (context) {

      return Container(
        height: MediaQuery.of(context).size.height*0.9,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 25,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New Post",
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w400
                  ,color: Colors.black87 ),
            ),
            SizedBox(height: 20,),

            /*
            title textfield
             */
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1,color: Colors.black87)
              ),
              child: TextField(
                controller: _title_controller,
                decoration: InputDecoration(
                  hintText: "Title",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none
                ),
              ),
            ),
            /*
            content textfield
             */
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1,color: Colors.black87)
              ),
              child: TextField(
                controller: _content_controller,
                decoration: InputDecoration(
                  hintText: "Content",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none
                ),
              ),
            ),

            SizedBox(height: 20,),

            Consumer<CategoryProvider>(
              builder: (context, value, child) {
                if(value.cat_list==null || value.cat_list!.isEmpty)
                  return Text("Empty");
                else{
                  /*
                  drop down button
                   */
                  selected_category = value.cat_list![0].title!;
                  return Container(
                    width: 150,
                    height: 45,
                    margin: EdgeInsets.only(bottom: 20,top: 10),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 2,color: Colors.black12)
                    ),
                    child: DropdownButtonFormField(
                      value: selected_category,
                      alignment: Alignment.topLeft,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: InputBorder.none,
                      ),
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      items: value.cat_list!.map((CategoryModel item)  {

                        return DropdownMenuItem(
                            value: item.title,
                            child: Text(item.title!));
                      }).toList(),

                    onChanged: (values) {
                      setState(() {
                        selected_category = values!;
                      });
                    },
                    ),

                  );


                }
              },
            ),

            SizedBox(height: 40,),

                /*
                save button
                 */
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.main_color
                    ),
                    onPressed: () {

                      // create postmodel object

                      dateTime = DateTime.now();

                      date_format = dateTime.year.toString()+":"+
                      dateTime.month.toString()+":"+dateTime.day.toString();
                      PostModel post = PostModel(0,
                      content: _content_controller.text,
                      title: _title_controller.text,
                      category: selected_category,
                      date: date_format);

                      var result = Provider.of<PostProvider>(context,listen: false).InsertPost(post);
                      if(result==true) Navigator.pop(context);
                    },
                    child: Text("Add",style: TextStyle(color: Colors.white),)),



          ],
        ),
      );

    },);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<CategoryProvider>(context,listen: false).GetCategoryList();
      Provider.of<PostProvider>(context,listen: false).GetPostList();

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){

          CreateCSV csv = CreateCSV(context);
          csv.CreateCSVFile(Provider.of<PostProvider>(context,listen: false).post_list);
        },
        child: Icon(Icons.file_copy_outlined),
      ),

      body: SafeArea(

        child: Container(
          child: Column(
            children: [

              Container(
                margin: EdgeInsets.only(top: 20,left: 15,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Create Note",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600
                   ,color: Colors.black54 ),),
                    InkWell(
                      onLongPress: () {
                        CreatePost();
                      },
                      onTap: () {

                        //CreatePost();
                        CreateCategory();
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 2,color: Colors.black54)
                        ),
                        child: Icon(Icons.add,size: 30,color: Colors.black54,),
                      ),
                    )
                  ],
                ),
              ),

              // category listview
              Container(
                height: 35,
                child: Consumer<CategoryProvider>(
                  builder: (context, value, child) {
                    if(value.cat_list!.isEmpty || value.cat_list==null){
                      return Text("Empty");
                    }else{

                      return ListView.builder(
                        itemCount:value.cat_list!.length ,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              //print("clicked");
                              CreateCategory(categoryModel: value.cat_list![index]);
                            },
                            onTap: () {
                              setState(() {
                                if(current_category==index){
                                  current_category = -1;
                                  Provider.of<PostProvider>(context,listen: false).
                                  GetPostList();

                                }else{
                                  current_category = index;
                                  Provider.of<PostProvider>(context,listen: false).
                                  GetPostCategoryList(value.cat_list![index].title!);
                                }

                              });


                            },

                            child: CategoryItem(value.cat_list![index],
                                current_category==index?true:false
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),

              // postlistview
              Container(
                height: 450,
                child: Consumer<PostProvider>(
                  builder: (context, value, child) {
                    if(value.post_list!.isEmpty || value.post_list==null){
                      return Text("Empty");
                    }else{

                      return ListView.builder(
                        itemCount:value.post_list!.length ,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              //print("clicked");
                            //  CreateCategory(categoryModel: value.post_list![index]);
                            },
                            child: PostItem(value.post_list![index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),

            ],
          ),

        ),
      )
    );
  }
}
