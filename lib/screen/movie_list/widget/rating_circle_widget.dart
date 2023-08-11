import 'package:bloc_project/style/pallete.dart';
import 'package:flutter/material.dart';

class RatingCircleWidget extends StatelessWidget {
  final double rating;

  const RatingCircleWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    double normalizedRating = rating / 10;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: CircularProgressIndicator(
            value: normalizedRating,
            strokeWidth: 3,
            valueColor: const AlwaysStoppedAnimation<Color>(Palette.primary),
            backgroundColor: Palette.background,
          ),
        ),
        Text(
          '$rating', // Виводимо рейтинг
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
