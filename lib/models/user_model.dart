class User {
  final int id;
  final String name;
  final String email;
  final String mobile;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
    );
  }
}
