import '../../domain/entities/user.dart';

class UserLoginModel extends User {
  UserLoginModel({required super.email, required super.password});

  factory UserLoginModel.fromJson(Map<String, String> json) {
    return UserLoginModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, String> toJson() {
  return {
    'email': email,
    'password': password,
  };
  }
}
