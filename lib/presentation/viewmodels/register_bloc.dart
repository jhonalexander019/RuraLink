import 'package:flutter/foundation.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/entities/user.dart';
import '../../util/register_validator.dart';

class RegisterBloc with ChangeNotifier {
  final RegisterUser registerUser;
  String? errorMessage;

  RegisterBloc(this.registerUser);

  Future<void> register(String email, String password, String confirmPassword) async {
    // Validación de email
    final emailError = RegisterValidator.validateEmail(email);
    if (emailError != null) {
      errorMessage = emailError;
      notifyListeners();
      return;
    }

    // Validación de contraseña
    final passwordError = RegisterValidator.validatePassword(password);
    if (passwordError != null) {
      errorMessage = passwordError;
      notifyListeners();
      return;
    }

    // Validación de confirmación de contraseña
    final confirmPasswordError = RegisterValidator.validateConfirmPassword(password, confirmPassword);
    if (confirmPasswordError != null) {
      errorMessage = confirmPasswordError;
      notifyListeners();
      return;
    }

    // Si las validaciones pasan, intenta el registro
    try {
      User? user = await registerUser(email, password, confirmPassword);
      if (user != null) {
        errorMessage = null; // Registro exitoso, limpia el mensaje de error
      } else {
        errorMessage = 'Error en el registro';
      }
    } catch (e) {
      errorMessage = 'Ocurrió un error';
    }
    notifyListeners();
  }
}
