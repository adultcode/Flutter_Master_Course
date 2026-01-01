class Phone {
  int? id,number;
  String? name;
  Phone({this.id,this.name,this.number});

  Map<String , Object?> toMap(){
    return {'id':id, 'name':name!,'number':number!};
  }

  Phone.fromMap(Map<String , dynamic> item):
      id = item["id"],
      name = item['name'],
        number = item['number'];
}

/*
          {
            "id":2,
            "name":"dsd"
          }
 */