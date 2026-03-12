import 'package:flutter/material.dart';
import 'create_challenge_screen.dart';
import 'admin_challenges_screen.dart';

class AdminDashboardScreen extends StatelessWidget {

  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),

      body: ListView(

        padding: const EdgeInsets.all(20),

        children: [

          ElevatedButton(

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateChallengeScreen(),
                ),
              );

            },

            child: const Text("Create Challenge"),

          ),

          const SizedBox(height: 20),

          ElevatedButton(

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminChallengesScreen(),
                ),
              );

            },

            child: const Text("Manage Challenges"),

          ),

        ],

      ),

    );
  }
}