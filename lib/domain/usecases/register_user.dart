import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User?> call(String email, String password, String confirmPassword) async {
    return await repository.register(email, password, confirmPassword);
  }
}
