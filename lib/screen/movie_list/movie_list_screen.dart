import 'package:bloc_project/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:bloc_project/screen/movie_list/widget/grid_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieListStatus.failure:
              return const Center(child: Text('failed to fetch posts'));
            case MovieListStatus.success:
              if (state.movieList.isEmpty) {
                return const Center(child: Text('no post'));
              }
              return GridListWidget(
                controller: _scrollController,
                state: state,
              );
            case MovieListStatus.initial:
              return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<MovieListBloc>().add(MovieListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }
}
