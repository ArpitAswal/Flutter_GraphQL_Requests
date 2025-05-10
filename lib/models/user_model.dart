// User Model: Represents the user data structure
// Handles serialization and deserialization of user data

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
  });

  /// Factory constructor to create a User instance from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  final String email;
  final String id;
  final String name;
  final String username;

  /// Convert User instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
    };
  }
}
