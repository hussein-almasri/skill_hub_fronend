import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';
import 'core/storage/secure_storage.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';

import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';

import 'presentation/cubits/auth_cubit.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const CTFApp());
}

class CTFApp extends StatelessWidget {
  const CTFApp({super.key});

  @override
  Widget build(BuildContext context) {

    final dio = DioClient().dio;

    final authRemoteDatasource = AuthRemoteDatasource(dio);

    final authRepository = AuthRepositoryImpl(authRemoteDatasource);

    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);

    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase,
        registerUseCase,
        SecureStorage(),
      ),
      child: MaterialApp(
        title: "CTF Platform",
        theme: AppTheme.darkTheme,
        home: LoginScreen(),
      ),
    );
  }
}