import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/challenges_cubit.dart';
import '../cubits/admin_cubit.dart';
import '../../domain/entities/challenge.dart';
import 'create_challenge_screen.dart';

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

                        /// 🔹 Add Hint
                        IconButton(
                          icon: const Icon(Icons.lightbulb, color: Colors.amber),
                          onPressed: () {

                            final hintController = TextEditingController();
                            final costController = TextEditingController();

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(

                                title: const Text("Add Hint"),

                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    TextField(
                                      controller: hintController,
                                      decoration: const InputDecoration(
                                        labelText: "Hint Text",
                                      ),
                                    ),

                                    TextField(
                                      controller: costController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Hint Cost",
                                      ),
                                    ),

                                  ],
                                ),

                                actions: [

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),

                                  ElevatedButton(
                                    onPressed: () {

                                      context.read<AdminCubit>().createHint(
                                        challenge.id,
                                        hintController.text,
                                        int.tryParse(costController.text) ?? 0,
                                      );

                                      Navigator.pop(context);

                                    },
                                    child: const Text("Create"),
                                  ),

                                ],
                              ),
                            );

                          },
                        ),

                        /// Edit
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateChallengeScreen(
                                  challenge: challenge,
                                ),
                              ),
                            );

                          },
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