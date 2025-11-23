import 'School.dart';
import 'person.dart';

class Teacher extends Person implements School{

  var course;

  Teacher(var name,var lastname,var course): super(name,lastname){
    this.course = course;
    print("Teacher created..");
  }
  void ShowCourse(){
    print("Course: $course");
  }

  @override
  void Intro(){
    print("I am Teacher $name $lastname");
  }

  @override
  void GotoClass() {
    // TODO: implement GotoClass
    print("Dr $name $lastname is going class");
  }

  @override
  void TakeCourse(course) {
    print("Dr $name $lastname teaching $course ");
  }
}