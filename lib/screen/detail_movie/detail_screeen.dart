import 'package:bloc_project/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/screen/detail_movie/widget/background_image_with_gradient.dart';
import 'package:bloc_project/screen/detail_movie/widget/cast.dart';
import 'package:bloc_project/screen/detail_movie/widget/movie_info.dart';
import 'package:bloc_project/screen/detail_movie/widget/trailer.dart';
import 'package:bloc_project/style/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailMovieScreen extends StatelessWidget {
  final MovieModel movie;

  const DetailMovieScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieDetailBloc>(
        create: (context) => MovieDetailBloc()
          ..add(
            MovieDetailFetched(movie.id),
          )
          ..add(
            TrailerListFetched(movie.id),
          )
        ..add(
            CastListFetched(movie.id),
          ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 450,
              floating: false,
              backgroundColor: Palette.background,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: BackgroundImageWithGradient(movie: movie),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Icon(Icons.favorite_border),
                ),
              ],
            ),
           const  SliverToBoxAdapter(child: MovieInfo()),
            const SliverToBoxAdapter(child: Trailer()),
            const SliverToBoxAdapter(child: Cast()),
          ],
        ),
      ),
    );
  }
}
