class TextGenerate{
static Future<int>? SumNumbs(int a , int b){
 return Future.delayed(Duration(seconds: 2),() => a+b,);
}

  static String? SayHi({var name}){
   return name!=null?  'Hi $name': throw Exception('Name is null');
  }
  static String PrintText(var _number){

    if(_number<5) return 'Low';
    else if(_number>= 5 && _number<10) return 'Medium';
    else return 'High';
  }

}