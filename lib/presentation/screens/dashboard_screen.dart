import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit.dart';
import 'challenges_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import 'admin_dashboard_screen.dart';

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

      appBar: AppBar(
        title: const Text("SkillHub"),
        actions: [

          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {

              if (state is UserLoaded && state.user.role == "admin") {

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminDashboardScreen(),
                        ),
                      );

                    },

                    child: const Text("Admin Panel"),
                  ),
                );
              }

              return const SizedBox();

            },
          ),

        ],
      ),

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