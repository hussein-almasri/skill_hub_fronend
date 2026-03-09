import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/admin_cubit.dart';
import '../cubits/challenges_cubit.dart';
import '../../data/models/create_challenge_model.dart';

class CreateChallengeScreen extends StatefulWidget {

  const CreateChallengeScreen({super.key});

  @override
  State<CreateChallengeScreen> createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final difficultyController = TextEditingController();
  final pointsController = TextEditingController();
  final categoryController = TextEditingController();
  final flagController = TextEditingController(); // 🔹 الجديد

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Create Challenge"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocConsumer<AdminCubit, AdminState>(

          listener: (context, state) {

            if (state is AdminSuccess) {

              /// تحديث قائمة التحديات
              context.read<ChallengesCubit>().fetchChallenges();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Challenge created"),
                ),
              );

              Navigator.pop(context);
            }

            if (state is AdminError) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );

            }

          },

          builder: (context, state) {

            if (state is AdminLoading) {

              return const Center(
                child: CircularProgressIndicator(),
              );

            }

            return SingleChildScrollView(

              child: Column(

                children: [

                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),

                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),

                  TextField(
                    controller: difficultyController,
                    decoration: const InputDecoration(labelText: "Difficulty"),
                  ),

                  TextField(
                    controller: pointsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Points"),
                  ),

                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: "Category"),
                  ),

                  /// 🔹 حقل الفلاق الجديد
                  TextField(
                    controller: flagController,
                    decoration: const InputDecoration(labelText: "Flag"),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(

                    onPressed: () {

                      final model = CreateChallengeModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        difficulty: difficultyController.text,
                        points: int.tryParse(pointsController.text) ?? 0,
                        category: categoryController.text,
                        flag: flagController.text, // 🔹 الجديد
                      );

                      context.read<AdminCubit>().createChallenge(model);

                    },

                    child: const Text("Create"),

                  )

                ],

              ),

            );

          },

        ),

      ),

    );

  }

}