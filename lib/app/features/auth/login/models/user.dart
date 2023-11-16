import 'dart:convert';

class User {
  final String? username;
  final String? password;
  final String? token;

  bool get isAdmin => username == 'Aluno' ? false : true;

  User({required this.username, required this.password, this.token});

  User copyWith({
    String? username,
    String? password,
    String? token,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  static User? fromJson(String? source) {
    if (source?.isEmpty ?? true) return User.fromMap({});
    return User.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String?,
      password: map['password'] as String?,
      token: map['token'] as String?,
    );
  }
}
