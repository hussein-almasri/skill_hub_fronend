import 'package:flutter/material.dart';

import '../../domain/entities/challenge.dart';
import '../../core/constants/difficulty_colors.dart';

class ChallengeCard extends StatelessWidget {

  final Challenge challenge;
  final VoidCallback onTap;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        onTap: onTap,

        title: Text(
          challenge.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          challenge.category,
        ),

        trailing: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              challenge.difficulty,
              style: TextStyle(
                color: difficultyColor(challenge.difficulty),
              ),
            ),

            Text("${challenge.points} pts"),

          ],

        ),

      ),

    );
  }
}