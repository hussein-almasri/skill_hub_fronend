import 'package:flutter/material.dart';

import 'challenges_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [

    ChallengesScreen(),
    LeaderboardScreen(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });

        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: "Challenges",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Leaderboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],

      ),

    );
  }
}