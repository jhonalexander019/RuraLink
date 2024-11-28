import '../../domain/entities/user.dart';

class UserRegisterModel extends User {
  final String username;
  final String confirmPassword;
  final int userTypeId;
  UserRegisterModel(this.username, this.confirmPassword, this.userTypeId, {required super.email,  required super.password});

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      json['username'], 
      json['confirmPassword'],
      json['userTypeId'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'username': username,
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
    'userTypeId': userTypeId,
  };
}

}
