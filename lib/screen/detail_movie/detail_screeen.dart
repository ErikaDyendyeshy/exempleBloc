import 'package:bloc_project/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/screen/detail_movie/widget/background_image_with_gradient.dart';
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
          ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 450,
              floating: false,
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
            SliverToBoxAdapter(
              child: MovieInfo(movie: movie),
            ),
            const SliverToBoxAdapter(
              child: Trailer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail() {
    return Container(
      color: Palette.background,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
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
                child: const Center(
                    child: Text(
                  '2019',
                )),
              ),
              Spacer(),
              Icon(Icons.favorite_border),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Palette.textPrimary)),
                child: const Text('16+'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('•'),
              ),
              SizedBox(
                height: 25,
                child: ListView.separated(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const VerticalDivider(
                          color: Palette.textPrimary,
                          width: 20,
                          endIndent: 5,
                          indent: 5,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: const [
                          Text(
                            'Жанр',
                            style: TextStyle(
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
          const Text(
            '1 год 42 хв',
            style: TextStyle(
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
          const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel lobortis libero, euismod eleifend est. Proin molestie, odio et vestibulum malesuada, mi mi ullamcorper ex, vitae gravida neque leo vitae lectus. Etiam pellentesque pellentesque nisl vel lobortis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce vel justo ultrices, rhoncus sem sed, aliquam sem. Aliquam pulvinar tempor arcu id lacinia.'),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trailer',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10),
                        child: Container(
                          width: 300,
                          height: 150,
                          child:
                              Image.network('https://i.ytimg.com/vi/qGwqXcS6Nm8/maxresdefault.jpg'),
                        ),
                      );
                    }),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 7),
            child: Text(
              'Акторський склад',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 170,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10),
                        child: ShaderMask(
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
                          child: SizedBox(
                            width: 130,
                            height: 150,
                            child: Image.network(
                                'https://i1.wp.com/topnews.ru/upload/photo/c9f5e2e3/d5ed9.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: 130,
                                child: Text(
                                  'Ezra Miller/Ezra Miller',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                )),
                          )),
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
