class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isAccountVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isAccountVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      isAccountVerified: json['isAccountVerified'] ?? false,
    );
  }
}
