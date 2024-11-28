import '../entities/user_home.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<UserHome?> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
