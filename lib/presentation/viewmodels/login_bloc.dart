import 'package:flutter/foundation.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/entities/user.dart';
import '../../util/login_validator.dart';

class LoginBloc with ChangeNotifier {
  final LoginUser loginUser;
  String? errorMessage;

  LoginBloc(this.loginUser);

  Future<void> login(String email, String password) async {
    // Validación de email
    final emailError = LoginValidator.validateEmail(email);
    if (emailError != null) {
      errorMessage = emailError;
      notifyListeners();
      return;
    }

    // Validación de contraseña
    final passwordError = LoginValidator.validatePassword(password);
    if (passwordError != null) {
      errorMessage = passwordError;
      notifyListeners();
      return;
    }

    // Si las validaciones pasan, intenta el inicio de sesión
    try {
      User? user = await loginUser(email, password);
      if (user != null) {
        errorMessage = null; // Login exitoso, limpia el mensaje de error
      } else {
        errorMessage = 'Error de autenticación';
      }
    } catch (e) {
      errorMessage = 'Ocurrió un error';
    }
    notifyListeners();
  }
}