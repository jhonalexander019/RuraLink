import 'package:flutter/foundation.dart';
import '../../domain/usecases/register_user.dart';
import '../../util/register_validator.dart';

class RegisterBloc with ChangeNotifier {
  final RegisterUser registerUser;
  String? errorMessage;
  String? successMessage;

  RegisterBloc(this.registerUser);

  Future<void> register(String username, String email, String password,
      String confirmPassword, int userTypeId) async {
    // Validación de username
    final usernameError = RegisterValidator.validateUsername(username);
    if (usernameError != null) {
      errorMessage = usernameError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Validación de email
    final emailError = RegisterValidator.validateEmail(email);
    if (emailError != null) {
      errorMessage = emailError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Validación de contraseña
    final passwordError = RegisterValidator.validatePassword(password);
    if (passwordError != null) {
      errorMessage = passwordError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Validación de confirmación de contraseña
    final confirmPasswordError =
        RegisterValidator.validateConfirmPassword(password, confirmPassword);
    if (confirmPasswordError != null) {
      errorMessage = confirmPasswordError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Validación de userTypeIdError
    final userTypeIdError = RegisterValidator.validateUserTypeId(userTypeId);
    if (userTypeIdError != null) {
      errorMessage = userTypeIdError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Si las validaciones pasan, intenta el registro
    try {
      bool? user = await registerUser(
          username: username,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userTypeId: userTypeId);

      if (user != false) {
        successMessage =
            "Te hemos enviado un correo de confirmación, valida e inicia sesion";
        _clearMessageAfterDelay();
      }
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      _clearMessageAfterDelay();
    }
    notifyListeners();
  }

  void _clearMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      errorMessage = null;
      successMessage = null;
      notifyListeners();
    });
  }
}
