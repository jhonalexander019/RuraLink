import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/register_user.dart';
import 'presentation/viewmodels/login_bloc.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/viewmodels/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración e inyección de dependencias
    final authRemoteDataSource = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final loginUserUseCase = LoginUser(authRepository);
    final registerUserUseCase = RegisterUser(authRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginBloc(loginUserUseCase),),
        ChangeNotifierProvider(create: (_) => RegisterBloc(registerUserUseCase)),
      ],
      child: MaterialApp(
        title: 'RuraLink',
        theme: ThemeData(
          fontFamily: 'Wondercity',
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Wondercity',
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: LoginScreen(),
      ),
    );
  }
}
