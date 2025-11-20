void main(){
  //PrintName();
  var name = MyName();
  // print(name);
  // print(MyAge());
  // ShowName("Hesam");
  // ShowName("Maral..");
  var result = Sum(8,6);
 // print(result);
 // print(pow(4));
  City("Paris",country: "France");
}
//name parameter
void City(var city,{ country="Iran" }){

  print("city: $city, country: $country");
}

int pow(var a){
  return a*a;
}
int Sum(var a,var b){
  var c = a + b;
  return c;
}
void ShowName(var name){
  print("Hello $name");
}

int MyAge(){
  print("Loading.....");
  return 10;
}
String MyName(){

  return "Flutter";
}
void PrintName(){
  print("Hello world");
  print("This is my function");
}