import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_home.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserHome> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    required int userTypeId,
  }) async {
    return await remoteDataSource.registerUser(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      username: username,
      userTypeId: userTypeId,
    );
  }
}
