import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/challenges_cubit.dart';
import '../cubits/admin_cubit.dart';
import '../../domain/entities/challenge.dart';

class AdminChallengesScreen extends StatelessWidget {

  const AdminChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<ChallengesCubit>().fetchChallenges();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Manage Challenges"),
      ),

      body: BlocBuilder<ChallengesCubit, ChallengesState>(
        builder: (context, state) {

          if (state is ChallengesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChallengesLoaded) {

            final List<Challenge> challenges = state.challenges;

            return ListView.builder(

              itemCount: challenges.length,

              itemBuilder: (context, index) {

                final challenge = challenges[index];

                return Card(

                  child: ListTile(

                    title: Text(challenge.title),

                    subtitle: Text(challenge.category),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        /// Edit
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),

                        /// Delete
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {

                            context.read<AdminCubit>().deleteChallenge(
                              challenge.id,
                            );

                          },
                        ),

                      ],
                    ),

                  ),

                );

              },

            );
          }

          return const SizedBox();
        },
      ),

    );
  }
}