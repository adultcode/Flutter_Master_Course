class UserModel{
  int? id;
  String? name;
  String? avatar;
  String? email;
  String? bio;
  int? follower;
  int? following;
  int? isfollow;
  int? post_count;

  UserModel({this.id, this.name, this.avatar, this.email, this.bio,
      this.follower, this.following, this.isfollow,this.post_count});

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    bio = json['bio'];
    follower = json['follower'];
    following = json['following'];
    isfollow = json['isfollow'];
    post_count = json['post_count'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['follower'] = this.follower;
    data['following'] = this.following;
    data['isfollow'] = this.isfollow;
    data['post_count'] = this.post_count;
    return data;
  }
}