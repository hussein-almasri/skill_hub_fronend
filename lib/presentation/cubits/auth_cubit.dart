import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/storage/secure_storage.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SecureStorage storage;

  AuthCubit(
    this.loginUseCase,
    this.registerUseCase,
    this.storage,
  ) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final auth = await loginUseCase(email, password);

      await storage.saveToken(auth.accessToken);

      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError("Login failed"));
    }
  }

  Future<void> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      emit(AuthLoading());

      await registerUseCase(username, email, password);

      emit(AuthRegistered());
    } catch (e) {
      emit(AuthError("Register failed"));
    }
  }

  Future<void> checkAuth() async {
    final token = await storage.getToken();

    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    await storage.deleteToken();
    emit(AuthInitial());
  }
}