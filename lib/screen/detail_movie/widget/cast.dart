import 'package:bloc_project/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:bloc_project/const.dart';
import 'package:bloc_project/data/model/cast_model.dart';
import 'package:bloc_project/style/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cast extends StatelessWidget {
  const Cast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(builder: (context, state) {
      switch (state.status) {
        case MovieDetailStatus.initial:
          return const Center(child: CupertinoActivityIndicator());
        case MovieDetailStatus.success:
          return _castList(castList: state.castList!);
        case MovieDetailStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
      }
    });
  }

  Widget _castList({required List<CastModel> castList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            'Акторський склад',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                final cast = castList[index];
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 12),
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
                          width: 180,
                          child:  cast.photoActor == null ? const SizedBox.shrink() : Image.network(
                            posterPath + cast.photoActor!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 16,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cast.name,
                                style: const TextStyle(fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              Text(
                                cast.character ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ],
                          ),
                        )),
                  ],
                );
              }),
        ),
        const SizedBox(height: 200)
      ],
    );
  }
}
