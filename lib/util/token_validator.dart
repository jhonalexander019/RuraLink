import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/viewmodels/token_bloc.dart';

class TokenValidator extends StatefulWidget {
  const TokenValidator({super.key});

  @override
  _TokenCheckerState createState() => _TokenCheckerState();
}

class _TokenCheckerState extends State<TokenValidator> {
  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final tokenBloc = Provider.of<TokenBloc>(context, listen: false);
    await tokenBloc.loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TokenBloc>(
      builder: (context, tokenBloc, child) {
        print('TokenValidator: ${tokenBloc.token}');

        // Verificar si está autenticado y redirigir a la pantalla correspondiente
        return const LoginScreen();
      },
    );
  }
}
