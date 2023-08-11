import 'package:bloc_project/const.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/screen/detail_movie/detail_screeen.dart';
import 'package:bloc_project/screen/movie_list/widget/rating_circle_widget.dart';
import 'package:bloc_project/style/pallete.dart';
import 'package:flutter/material.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieModel movie;

  const MovieItemWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (Rect rect) {
            return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  .7,
                  1
                ],
                colors: [
                  Colors.transparent,
                  Palette.background,
                ]).createShader(rect);
          },
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DetailMovieScreen(
                  movie: movie,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ), // Задаємо радіус країв
              child: Image.network(
                posterPath + movie.posterPath,
                fit: BoxFit.fitWidth,
                height: 260,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 85,
          left: 5,
          child: RatingCircleWidget(
            rating: movie.rating,
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                maxLines: 2,
                // textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                movie.releaseDate,
                // textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
