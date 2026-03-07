import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/leaderboard_cubit.dart';

class LeaderboardScreen extends StatelessWidget {

  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<LeaderboardCubit>().fetchLeaderboard();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),

      body: BlocBuilder<LeaderboardCubit, LeaderboardState>(

        builder: (context, state) {

          if (state is LeaderboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LeaderboardLoaded) {

            return ListView.builder(

              itemCount: state.users.length,

              itemBuilder: (context, index) {

                final user = state.users[index];

                return ListTile(

                  leading: Text("#${index + 1}"),

                  title: Text(user.username),

                  trailing: Text("${user.points} pts"),

                );

              },

            );

          }

          return const Center(child: Text("Error loading leaderboard"));

        },

      ),

    );

  }

}