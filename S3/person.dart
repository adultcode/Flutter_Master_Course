class Person{


  var name;
  var lastname;
  Person(var name,var lastname){
    this.name = name;
    this.lastname = lastname;
    print("Person created");
  }

  void Intro(){
    print("I am $name $lastname");
  }
}