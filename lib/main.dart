import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'presentation/cubits/auth_cubit.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const CTFApp());
}

class CTFApp extends StatelessWidget {
  const CTFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CTF Platform",
      theme: AppTheme.darkTheme,
      home: LoginScreen(),
    );
  }
}