import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/register_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Auth> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<void> register(
    String username,
    String email,
    String password,
  ) {
    final model = RegisterModel(
      username: username,
      email: email,
      password: password,
    );

    return remoteDatasource.register(model);
  }
}