class Blog {
  final int id;
  final String title;
  final String body;

  Blog({
    required this.id,
    required this.title,
    required this.body
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      body:json['body']
    );
  }
}