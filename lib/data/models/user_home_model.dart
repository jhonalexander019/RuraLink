
import '../../domain/entities/user_home.dart';

class UserHomeModel extends UserHome{

  UserHomeModel({required super.id, required super.token});

  factory UserHomeModel.fromJson(Map<String, dynamic> json) {
    return UserHomeModel(
      id: json['\$id'].toString(),
      token: json['token'].toString(),
    );
  }

  Map<String, String> toJson() {
  return {
    '\$id': id,
    'token': token,
  };
  }
}
