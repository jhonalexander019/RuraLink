import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/register_bloc.dart';
import '../widgets/register_form.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = Provider.of<RegisterBloc>(context);

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
                  'Registrate',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RegisterForm(
                onRegister: (email, password, confirmPassword) {
                  registerBloc.register(email, password, confirmPassword);
                },
              ),
              const SizedBox(height: 10),
              if (registerBloc.errorMessage != null)
                Text(
                  registerBloc.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: '¿Ya tienes una cuenta? ',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Wondercity',
                        ),
                    children: [
                      TextSpan(
                        text: 'Inicia sesión',
                        style: TextStyle(
                          color:
                              Colors.green, // Color solo para "Inicia sesión"
                          fontWeight: FontWeight.bold, 
                          fontFamily: 'Wondercity',

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
