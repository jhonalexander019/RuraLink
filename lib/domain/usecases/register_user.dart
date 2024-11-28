import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<bool?> call({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required int userTypeId,
  }) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      userTypeId: userTypeId,
    );
  }
}
