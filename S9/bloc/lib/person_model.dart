class Person{

  final String name;
  final int money;

  Person({required this.name,required this.money});

 Person copyWith({String? name,int? money}){
   return Person(
     name: name?? this.name,
     money:  money ?? this.money
   );
 }
}