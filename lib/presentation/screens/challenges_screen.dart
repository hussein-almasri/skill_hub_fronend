import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/challenges_cubit.dart';
import 'challenge_details_screen.dart';
import '../widgets/challenge_card.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {

  String searchQuery = "";
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    context.read<ChallengesCubit>().fetchChallenges();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Challenges"),
      ),

      body: Column(
        children: [

          /// 🔎 Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(

              decoration: InputDecoration(
                hintText: "Search challenges...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },

            ),
          ),

          /// 🔹 Filters
          SizedBox(
            height: 50,
            child: ListView(

              scrollDirection: Axis.horizontal,

              children: [

                filterChip("All"),
                filterChip("Web"),
                filterChip("Crypto"),
                filterChip("Pwn"),
                filterChip("Reverse"),
                filterChip("Forensics"),

              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(

            child: BlocBuilder<ChallengesCubit, ChallengesState>(
              builder: (context, state) {

                if (state is ChallengesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ChallengesLoaded) {

                  /// 🔹 فلترة التحديات
                  final filtered = state.challenges.where((challenge) {

                    final matchSearch =
                        challenge.title.toLowerCase().contains(searchQuery) ||
                        challenge.category.toLowerCase().contains(searchQuery);

                    final matchCategory =
                        selectedCategory == "All" ||
                        challenge.category == selectedCategory;

                    return matchSearch && matchCategory;

                  }).toList();

                  return ListView.builder(

                    itemCount: filtered.length,

                    itemBuilder: (context, index) {

                      final challenge = filtered[index];

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

                return const Center(
                  child: Text("No Challenges"),
                );
              },
            ),

          )

        ],
      ),
    );
  }

  /// 🔹 Filter Button Widget
  Widget filterChip(String category) {

    final selected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),

      child: ChoiceChip(

        label: Text(category),

        selected: selected,

        onSelected: (_) {

          setState(() {
            selectedCategory = category;
          });

        },

      ),

    );
  }
}