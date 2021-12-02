class Forum {
  final int id;
  final String title;
  final String body;
  final int author;

  Forum({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
        id: json['id'],
        title: json['post_title'],
        body:json['post_body'],
        author:json['post_author'],
    );
  }
}

class Comments{
  final int id;
  final String comment;
  final int comment_author;
  final int comment_post;

  Comments({
    required this.id,
    required this.comment,
    required this.comment_author,
    required this.comment_post
});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
        id: json['id'],
        comment: json['comment'],
        comment_author: json['comment_author'],
        comment_post:json["comment_post"]
    );
  }

}

class User {
  final int id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        username:json['username'],
    );
  }
}


