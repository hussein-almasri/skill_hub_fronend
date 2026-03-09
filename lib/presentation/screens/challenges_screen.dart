import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/challenges_cubit.dart';
import 'challenge_details_screen.dart';
import '../widgets/challenge_card.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<ChallengesCubit>().fetchChallenges();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Challenges"),
      ),

      body: BlocBuilder<ChallengesCubit, ChallengesState>(
        builder: (context, state) {

          if (state is ChallengesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChallengesLoaded) {

            return ListView.builder(
              itemCount: state.challenges.length,
              itemBuilder: (context, index) {

                final challenge = state.challenges[index];

                /// هل التحدي محلول
                final solved = context.read<ChallengesCubit>()
                    .solvedChallenges
                    .contains(challenge.id);

                return ChallengeCard(
                  challenge: challenge,
                  solved: solved,

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChallengeDetailsScreen(
                          challengeId: challenge.id,
                        ),
                      ),
                    );

                  },
                );
              },
            );
          }

          return const Center(child: Text("No Challenges"));
        },
      ),
    );
  }
}