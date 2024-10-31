import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User?> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } catch (e) {
      return null;
    }
  }

   @override
  Future<User?> register(String email, String password, String confirmPassword) async {
    UserModel? userModel = await remoteDataSource.register(email, password, confirmPassword);
    return userModel != null ? User(id: userModel.id, email: userModel.email) : null;
  }
}
