import '../entities/user_home.dart';

abstract class AuthRepository {
  Future<UserHome> login(String email, String password);
  Future<bool> register({required String username, required String email, required String password, required String confirmPassword, required int userTypeId});
}
