import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/challenge.dart';
import '../cubits/submission_cubit.dart';

class ChallengeDetailsScreen extends StatelessWidget {

  final Challenge challenge;

  ChallengeDetailsScreen({super.key, required this.challenge});

  final flagController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(challenge.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              challenge.title,
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 10),

            Text(
              challenge.description,
            ),

            const SizedBox(height: 20),

            Text("Difficulty: ${challenge.difficulty}"),
            Text("Points: ${challenge.points}"),

            const SizedBox(height: 30),

            TextField(

              controller: flagController,

              style: const TextStyle(
                fontFamily: "monospace",
              ),

              decoration: const InputDecoration(

                labelText: "Enter Flag",

                prefixText: "flag> ",

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 20),

            BlocConsumer<SubmissionCubit, SubmissionState>(

              listener: (context, state) {

                if (state is SubmissionSuccess) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Correct Flag 🎉"),
                    ),
                  );

                }

                if (state is SubmissionError) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Wrong Flag ❌"),
                    ),
                  );

                }

              },

              builder: (context, state) {

                if (state is SubmissionLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(

                  onPressed: () {

                    context.read<SubmissionCubit>().submitFlag(
                      challenge.id,
                      flagController.text,
                    );

                  },

                  child: const Text("Submit Flag"),
                );

              },
            )

          ],
        ),
      ),
    );
  }
}