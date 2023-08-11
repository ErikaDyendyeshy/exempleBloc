import 'package:bloc_project/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/style/pallete.dart';
import 'package:bloc_project/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieInfo extends StatelessWidget {
  final MovieModel movie;

  const MovieInfo({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(builder: (context, state) {
      switch (state.status) {
        case MovieDetailStatus.initial:
          return const Center(child: CupertinoActivityIndicator());
        case MovieDetailStatus.success:
          return _detail(movie: state.movie!);
        case MovieDetailStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
      }
    });
  }

  Widget _detail({required MovieModel movie}) {
    return Container(
      color: Palette.background,
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      end: Alignment.bottomLeft,
                      begin: Alignment.topRight,
                      colors: [
                        Palette.blackRed,
                        Palette.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: Text(
                    Utils.formatFullDate(
                      movie.releaseDate,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Palette.textPrimary),
              ),
              child: const Text('16+'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('•'),
            ),
            SizedBox(
              height: 25,
              child: ListView.separated(
                  itemCount: movie.genreList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => const VerticalDivider(
                        color: Palette.textPrimary,
                        width: 20,
                        endIndent: 5,
                        indent: 5,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    final genre = movie.genreList[index];
                    return Row(
                      children: [
                        Text(
                          genre.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          Utils.formatRuntime(movie.runtime),

          // movie.runtime.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 7),
          child: Text(
            'Обзор',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        Text(
          movie.overview,
        ),
        const SizedBox(
          height: 30,
        ),
      ]),
    );
  }
}
