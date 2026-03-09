import 'package:flutter/material.dart';

import '../../domain/entities/challenge.dart';
import '../../core/constants/difficulty_colors.dart';

class ChallengeCard extends StatelessWidget {

  final Challenge challenge;
  final VoidCallback onTap;
  final bool solved; 

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onTap,
    this.solved = false,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      color: solved ? Colors.green.withOpacity(0.2) : null,

      child: ListTile(

        onTap: onTap,

        title: Text(
          challenge.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          challenge.category,
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            if (solved)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),

            Column(

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
          ],
        ),

      ),

    );
  }
}