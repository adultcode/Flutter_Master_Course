

void main(){
  // List

  var names = ["Hadi"];
  names.add("Hesam"); // index: 0
  names.add("Arman"); // index: 1
  // size: 2
   //print(names[0]);
  //
  // names[0] = "Amir";
  // print(names[0]);

  // print("Size: ${names.length}");
  names.add("Saba");
  // print("Size: ${names.length}");
 // print(names.first);
  //names.clear();
 // print(names.contains("Saba"));
 //  names.remove("Hadi");

  // for(var a=0;a<names.length;a++){
  //   if(names[a]=="Hamid") print("Yes, contains Arman");
  //   else print("No");
  // }

  // var fixed =  List<int>.filled(2,1,growable: true);
  // fixed[0] = 20;
  // fixed[1] = 30;
  // print(fixed[0]);
  // fixed.add(40);
  // print(fixed.length);

  // key-value
  //var map = Map();
  // var map = {"Age":"11","city":"Tehran"};
  // map["car"] = "BMW";
  // map["phone"] = "Apple";
  // //map.remove("car");
  //
  // //print(map["phone"]);
  // //print(map.values.contains("BMW"));
  // map.forEach((key, value) {
  //   print("$key - $value");
  // });
  var brand = <String>{"Samsung","hp","microsoft"};
  //brand.add("hp2");
  //print(brand.elementAt(3));
  // for(var a=0;a<brand.length;a++){
  //   print(brand.elementAt(a));
  // }
  // brand.forEach((element) {
  //   print(element);
  // });
  print(brand.lookup("hpp"));
}
