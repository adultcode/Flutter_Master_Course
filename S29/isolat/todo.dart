class Todo{

final  int userId;
final int id;
final String title;
final bool isCompleted;

Todo({required this.userId,required this.id,required this.title,required this.isCompleted});

Todo.fromJson(Map<String,dynamic> json):
    userId  = json['userId'],
      id  = json['id'],
      title  = json['title'],
      isCompleted  = json['completed'];
}