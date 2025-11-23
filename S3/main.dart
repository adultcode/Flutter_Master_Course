import 'student.dart';
import 'teacher.dart';

void main(){

  var student = Student("Hesam", "Rasoulian",2010);
  var teacher = Teacher("Amir","Jafari","Math");
   // student.Intro();
   // teacher.Intro();
  student.GotoClass();
  student.TakeCourse("Math");
  teacher.TakeCourse("Computer");
  teacher.GotoClass();


/*
------------------------------------------------
 */
  // var s1 = Student("Hesam","Rasoulian",5);
  // var s2 = Student.Name("Ehsan");
  //
  // // s1.name = "Hesam";
  // // s1.lastname = "Rasoulian";
  // // s1.age = 5;
  //
  // s1.Intro();
  // s2.Intro();
  // // s1.age = 60;
  // // s1.Intro();
  // s1.name = "New Hesam";
  // print("new name: ${s1.name}");
}


