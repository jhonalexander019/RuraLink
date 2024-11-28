import 'package:flutter/material.dart';
import '../../util/register_validator.dart';

class RegisterForm extends StatefulWidget {
  final Function(String username, String email, String password,
      String confirmPassword, int userTypeId) onRegister;

  const RegisterForm({super.key, required this.onRegister});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userTypeIdController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Nombre de usuario',
              labelStyle: TextStyle(color: Colors.grey),
            ),
            validator: (value) {
              return RegisterValidator.validateUsername(value ?? '');
            },
          ),
          const SizedBox(height: 7),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Correo Electrónico',
              labelStyle: TextStyle(color: Colors.grey),
            ),
            validator: (value) {
              return RegisterValidator.validateEmail(value ?? '');
            },
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 7),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              return RegisterValidator.validatePassword(value ?? '');
            },
          ),
          const SizedBox(height: 7),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirma tu contraseña',
              labelStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureRepeatPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureRepeatPassword = !_obscureRepeatPassword;
                  });
                },
              ),
            ),
            obscureText: _obscureRepeatPassword,
            validator: (value) {
              return RegisterValidator.validateConfirmPassword(
                  _passwordController.text, value ?? '');
            },
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Seleccione su rol',
              labelStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
            ),
            value: _userTypeIdController.text.isEmpty
                ? null
                : int.tryParse(_userTypeIdController.text),
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text("Pasajero"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Conductor"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _userTypeIdController.text = value?.toString() ?? '';
              });
            },
            validator: (value) {
              return RegisterValidator.validateUserTypeId(value ?? 0);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onRegister(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                  int.tryParse(_userTypeIdController.text) ?? 0,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('Regístrate'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userTypeIdController.dispose();
    super.dispose();
  }
}
