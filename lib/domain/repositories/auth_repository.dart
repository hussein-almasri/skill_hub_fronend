import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Auth> login(String email, String password);

  Future<void> register(
    String username,
    String email,
    String password,
  );
}