import 'package:bloc_project/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:bloc_project/screen/movie_list/movie_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListBloc>(
      create: (context) => MovieListBloc()..add(MovieListFetched()),
      child: const MovieListScreen(),
    );
  }
}
