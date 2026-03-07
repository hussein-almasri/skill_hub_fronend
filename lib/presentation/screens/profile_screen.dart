import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<UserCubit>().fetchUser();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: BlocBuilder<UserCubit, UserState>(

        builder: (context, state) {

          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {

            final user = state.user;

            return Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 24),
                  ),

                  const SizedBox(height: 10),

                  Text(user.email),

                  const SizedBox(height: 10),

                  Text("Role: ${user.role}"),

                ],
              ),
            );

          }

          return const Center(child: Text("Error loading profile"));

        },

      ),

    );

  }

}