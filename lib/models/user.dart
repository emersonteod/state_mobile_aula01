class User {
  final int id;
  final String username;
  final String token;
  final String? firstName;
  final String? lastName;

  User({
    required this.id,
    required this.username,
    required this.token,
    this.firstName,
    this.lastName,
  });

  String get displayName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return username;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      token: json['token'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );
  }
}
