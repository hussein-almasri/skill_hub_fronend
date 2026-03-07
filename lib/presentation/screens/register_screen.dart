import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_hub_fronend/presentation/screens/dashboard_screen.dart';

import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: BlocConsumer<AuthCubit, AuthState>(

        listener: (context, state) {

          if (state is AuthAuthenticated) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const DashboardScreen(),
              ),
            );

          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {

          return Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              children: [

                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),

                const SizedBox(height: 20),

                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {

                          context.read<AuthCubit>().register(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                              );

                        },
                        child: const Text("Register"),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}