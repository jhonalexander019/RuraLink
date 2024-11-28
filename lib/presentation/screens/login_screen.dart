import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_bloc.dart';
import '../widgets/alert_message.dart';
import '../widgets/login_form.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of<LoginBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          title: const SizedBox.shrink(),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/car.png',
                height: 80,
              ),
              const SizedBox(height: 10),
              const Text(
                'RuraLink',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              LoginForm(
                onLogin: (email, password) {
                  loginBloc.login(context, email, password);
                },
              ),
              const SizedBox(height: 10),
              if (loginBloc.errorMessage != null)
                AlertMessage(message: loginBloc.errorMessage!, isSuccess: false),
              const SizedBox(height: 20),
              const Text(
                'O usa una de tus redes sociales',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton('Twitter', Colors.blue),
                  const SizedBox(width: 10),
                  _buildSocialButton('Facebook', Colors.indigo),
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Regístrate',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        // Acción de login social
      },
      icon: Icon(
        text == 'Twitter'
            ? Icons.alternate_email
            : text == 'Facebook'
                ? Icons.facebook
                : null,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
