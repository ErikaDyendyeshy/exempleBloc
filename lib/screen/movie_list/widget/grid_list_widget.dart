import 'package:bloc_project/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:bloc_project/screen/movie_list/widget/movie_item_widget.dart';
import 'package:flutter/material.dart';

class GridListWidget extends StatelessWidget {
  final ScrollController controller;
  final MovieListState state;

  const GridListWidget({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 350,
        ),
        controller: controller,
        itemCount: state.hasReachedMax ? state.movieList.length : state.movieList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index >= state.movieList.length
              ? const CircularProgressIndicator()
              : Hero(
                  tag: 'poster_${state.movieList[index].id}',
                  child: MovieItemWidget(
                    movie: state.movieList[index],
                  ),
                );
        },
      ),
    );
  }
}
