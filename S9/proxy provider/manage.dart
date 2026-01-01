class Manage{

  int? students;
  int? classes;

  Manage({this.students, this.classes});

  String Calcute(){
    // students: 20
    // classes: 4 (class capacity: 5)
    //
    var result = students!/classes!;

    if( result>5) return "Capacity is full";
    else return " We are hiring ";
  }
}