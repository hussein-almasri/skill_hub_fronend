import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().fetchStats();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {

            if (state is UserStatsLoaded) {

              final stats = state.stats;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    stats.username,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(stats.email),

                  const SizedBox(height: 20),

                  Card(
                    child: ListTile(
                      title: const Text("Points"),
                      trailing: Text("${stats.points}"),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: const Text("Solved Challenges"),
                      trailing: Text("${stats.solvedChallenges}"),
                    ),
                  ),

                ],
              );

            }

            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const SizedBox();

          },
        ),
      ),
    );
  }
}