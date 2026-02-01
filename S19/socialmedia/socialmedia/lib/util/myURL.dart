class Urls{

  static var website = "http://10.0.2.2:8000/";
  static var media = "http://10.0.2.2:8000";
  static var login = "login/"; // post: password, username
  static var signup = "signup/"; // post: password, username
  static var posts = "posts/"; // get
  static var like = "like/"; // post: postid
  static var get_comment = "get-comment/"; // post: postid
  static var send_comment = "comment/"; // post: postid,comment
  static var send_post = "send-post/"; // post: img,content
  static var user_page = "user-page/?target_user=";
  static var follow = "follow/"; //post: target_user, isfollow 0,1
  static var edit_profile = "edit-profile/"; //post: img, name, bio
}