import 'package:flutter/material.dart';

Color difficultyColor(String difficulty) {

  switch (difficulty.toLowerCase()) {

    case "easy":
      return Colors.green;

    case "medium":
      return Colors.orange;

    case "hard":
      return Colors.red;

    default:
      return Colors.grey;

  }

}