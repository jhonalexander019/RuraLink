import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://api.ejemplo.com/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en autenticación');
    }
  }

  Future<UserModel?> register(String email, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('https://api.ejemplo.com/register'),
      body: {'email': email, 'password': password, 'confirm_password': confirmPassword},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en registro');
    }
  }
}
