import 'package:provider/provider.dart';
import 'package:ruralink/presentation/viewmodels/token_bloc.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/entities/user_home.dart';
import '../../util/login_validator.dart';
import '../screens/home_screen.dart';

class LoginBloc with ChangeNotifier {
  final LoginUser loginUser;
  String? errorMessage;

  LoginBloc(this.loginUser);

  Future<void> login(
      BuildContext context, String email, String password) async {

    // Validación de email
    final emailError = LoginValidator.validateEmail(email);
    if (emailError != null) {
      errorMessage = emailError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Validación de contraseña
    final passwordError = LoginValidator.validatePassword(password);
    if (passwordError != null) {
      errorMessage = passwordError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    // Si las validaciones pasan, intenta el inicio de sesión
    try {
      UserHome? user = await loginUser(email, password);

      if (user != null) {
        final tokenProvider = Provider.of<TokenBloc>(context, listen: false);

        await tokenProvider.saveToken(user.token);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
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
      notifyListeners();
    });
  }
}
