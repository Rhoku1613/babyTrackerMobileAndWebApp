class AuthResponse {
  final String token;
  final String refresh_token;

  AuthResponse({required this.token, required this.refresh_token});
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        token: json['token'], refresh_token: json['refresh_token']);
  }
}


class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}