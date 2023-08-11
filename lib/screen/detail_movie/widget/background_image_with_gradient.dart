import 'package:bloc_project/const.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/style/pallete.dart';
import 'package:flutter/material.dart';

class BackgroundImageWithGradient extends StatelessWidget {
  final MovieModel movie;

  const BackgroundImageWithGradient({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'poster_${movie.id}',
          child: Image.network(
            posterPath + movie.posterPath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Palette.background,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
