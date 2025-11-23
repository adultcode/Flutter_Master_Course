// jalase inheritance


import 'School.dart';
import 'person.dart';

class Student extends Person implements School{

  var year;
  Student(var name,var lastname,var year): super(name,lastname){
    this.year = year;
    print(" student created");
  }
  void ShowYear(){
    print("year: $year");
  }

  @override
  void GotoClass() {
    print("$name is going to class");
  }

  @override
  void TakeCourse(course) {
    print("$name taking the $course course");
  }


}











// jalase aval
// class Student{
// // name, last name, age
//   var _name;
//   var lastname;
//   var age;
//   //CONSTRUCTOR
//   Student(var name,var lastname,var age){
//     this._name = name;
//     this.lastname = lastname;
//     this.age = age;
//     print("Object created");
//   }
//   Student.Name(var name){
//     this._name = name;
//     print("Object created");
//   }
//
//   // getter & setter
//   void set name(var name){
//     this._name = name;
//   }
//   String get name{
//     return this._name;
//   }
//   void Intro(){
//     print("name: $_name, Lastname: $lastname, Age: $age");
//   }
// }
