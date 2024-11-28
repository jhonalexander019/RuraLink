import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_home_model.dart';
import '../models/user_login_model.dart';
import '../models/user_register_model.dart';

class AuthRemoteDataSource {
  final String baseUrl = 'https://back.transporting.icitycolombia.com/api';

  Future<UserHomeModel> login(String email, String password) async {
    final Uri url = Uri.parse('$baseUrl/users/login');

    final UserLoginModel requestBody =
        UserLoginModel(email: email, password: password);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody.toJson()),
    );
    if (response.statusCode == 200) {
      return UserHomeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error en el inicio de sesión: Credenciales incorrectas');
    }
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    required int userTypeId,
  }) async {
    final Uri url = Uri.parse('$baseUrl/users');

    final UserRegisterModel requestBody = UserRegisterModel(
      username,
      email: email,
      password: password,
      confirmPassword,
      userTypeId,
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Error en el registro: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
