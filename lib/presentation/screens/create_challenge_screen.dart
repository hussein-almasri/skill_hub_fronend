import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/admin_cubit.dart';
import '../cubits/challenges_cubit.dart';
import '../../data/models/create_challenge_model.dart';
import '../../domain/entities/challenge.dart';

class CreateChallengeScreen extends StatefulWidget {

  final Challenge? challenge;

  const CreateChallengeScreen({
    super.key,
    this.challenge,
  });

  @override
  State<CreateChallengeScreen> createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final difficultyController = TextEditingController();
  final pointsController = TextEditingController();
  final categoryController = TextEditingController();
  final flagController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.challenge != null) {

      titleController.text = widget.challenge!.title;
      descriptionController.text = widget.challenge!.description;
      difficultyController.text = widget.challenge!.difficulty;
      pointsController.text = widget.challenge!.points.toString();
      categoryController.text = widget.challenge!.category;

    }
  }

  @override
  Widget build(BuildContext context) {

    final isEdit = widget.challenge != null;

    return Scaffold(

      appBar: AppBar(
        title: Text(isEdit ? "Edit Challenge" : "Create Challenge"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocConsumer<AdminCubit, AdminState>(

          listener: (context, state) {

            if (state is AdminSuccess) {

              context.read<ChallengesCubit>().fetchChallenges();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isEdit
                        ? "Challenge updated"
                        : "Challenge created",
                  ),
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

                  /// flag يظهر فقط عند الإنشاء
                  if (!isEdit)
                    TextField(
                      controller: flagController,
                      decoration: const InputDecoration(labelText: "Flag"),
                    ),

                  const SizedBox(height: 20),

                  ElevatedButton(

                    onPressed: () {

                      if (isEdit) {

                        context.read<AdminCubit>().updateChallenge(
                          widget.challenge!.id,
                          {
                            "title": titleController.text,
                            "description": descriptionController.text,
                            "difficulty": difficultyController.text,
                            "points": int.tryParse(pointsController.text) ?? 0,
                            "category": categoryController.text,
                          },
                        );

                      } else {

                        final model = CreateChallengeModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          difficulty: difficultyController.text,
                          points: int.tryParse(pointsController.text) ?? 0,
                          category: categoryController.text,
                          flag: flagController.text,
                        );

                        context.read<AdminCubit>().createChallenge(model);

                      }

                    },

                    child: Text(
                      isEdit ? "Update Challenge" : "Create",
                    ),

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