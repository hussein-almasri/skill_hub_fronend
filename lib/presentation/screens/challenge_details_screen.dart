import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/challenge_details_cubit.dart';
import '../cubits/submission_cubit.dart';
import '../cubits/challenges_cubit.dart';
import '../cubits/leaderboard_cubit.dart';
import '../cubits/hints_cubit.dart';
import '../../domain/entities/challenge.dart';

class ChallengeDetailsScreen extends StatefulWidget {

  final int challengeId;

  const ChallengeDetailsScreen({
    super.key,
    required this.challengeId,
  });

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {

  final flagController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ChallengeDetailsCubit>().fetchChallenge(widget.challengeId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Challenge"),
      ),

      body: BlocBuilder<ChallengeDetailsCubit, ChallengeDetailsState>(
        builder: (context, state) {

          if (state is ChallengeDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ChallengeDetailsLoaded) {

            final Challenge challenge = state.challenge;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Title
                  Text(
                    challenge.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Difficulty
                  Row(
                    children: [

                      Chip(
                        label: Text(
                          challenge.difficulty,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Chip(
                        label: Text(
                          "${challenge.points} pts",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Description
                  Text(
                    challenge.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  /// Hints Button
                  ElevatedButton(

                    onPressed: () {

                      context.read<HintsCubit>().fetchHints(widget.challengeId);

                      showModalBottomSheet(

                        context: context,

                        builder: (_) {

                          return BlocBuilder<HintsCubit, HintsState>(

                            builder: (context, state) {

                              if (state is HintsLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is HintsLoaded) {

                                return ListView.builder(

                                  itemCount: state.hints.length,

                                  itemBuilder: (context, index) {

                                    final hint = state.hints[index];

                                    return ListTile(

                                      title: Text("Hint ${index + 1}"),
                                      subtitle: Text("Cost: ${hint.cost}"),

                                      onTap: () {

                                        showDialog(

                                          context: context,

                                          builder: (_) => AlertDialog(

                                            title: const Text("Hint"),

                                            content: Text(hint.hintText),

                                          ),

                                        );

                                      },

                                    );

                                  },

                                );

                              }

                              return const SizedBox();

                            },

                          );

                        },

                      );

                    },

                    child: const Text("Hints"),

                  ),

                  const SizedBox(height: 30),

                  /// Flag Input
                  TextField(
                    controller: flagController,
                    decoration: const InputDecoration(
                      labelText: "Enter Flag",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Submit Button
                  BlocConsumer<SubmissionCubit, SubmissionState>(

                    listener: (context, state) {

                      if (state is SubmissionSuccess) {

                        context.read<ChallengesCubit>()
                            .solvedChallenges
                            .add(state.challengeId);

                        /// تحديث leaderboard
                        context.read<LeaderboardCubit>().fetchLeaderboard();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Correct Flag 🎉"),
                          ),
                        );

                      }

                      if (state is SubmissionError) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Wrong Flag ❌"),
                          ),
                        );

                      }

                    },

                    builder: (context, state) {

                      if (state is SubmissionLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(

                          onPressed: () {

                            final solved = context
                                .read<ChallengesCubit>()
                                .solvedChallenges
                                .contains(widget.challengeId);

                            if (solved) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.orange,
                                  content: Text("Challenge already solved ✔"),
                                ),
                              );

                              return;
                            }

                            final flag = flagController.text;

                            context.read<SubmissionCubit>().submit(
                              widget.challengeId,
                              flag,
                            );

                          },

                          child: const Text("Submit Flag"),
                        ),
                      );

                    },
                  )
                ],
              ),
            );
          }

          if (state is ChallengeDetailsError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}