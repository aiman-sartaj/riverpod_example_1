class User {
  final String name;
  final String email;

  User({required this.email, required this.name});

  static User fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
      };
}
