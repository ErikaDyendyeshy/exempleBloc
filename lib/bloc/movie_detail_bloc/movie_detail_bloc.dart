import 'package:bloc_project/data/model/cast_model.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/data/model/trailer_model.dart';
import 'package:bloc_project/domain/repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository _movieRepository = GetIt.instance.get<MovieRepository>();
  late YoutubePlayerController controller;

  MovieDetailBloc() : super(MovieDetailState()) {
    on<MovieDetailFetched>(_onMovieDetailFetched);
    on<TrailerListFetched>(_onTrailerFetched);
    on<CastListFetched>(_onCastFetched);
  }

  Future<void> _onMovieDetailFetched(
      MovieDetailFetched event, Emitter<MovieDetailState> emit) async {
    state.copyWith(
      isLoading: true
    );
    try {
      if (state.status == MovieDetailStatus.initial) {
        final newMovie = await _movieRepository.getMovieById(movieId: event.movieId);
        return emit(state.copyWith(
          status: MovieDetailStatus.success,
          movie: newMovie,
          isLoading: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: MovieDetailStatus.failure));
    }
  }

  Future<void> _onTrailerFetched(TrailerListFetched event, Emitter<MovieDetailState> emit) async {

    try {
      if (state.status == MovieDetailStatus.initial) {
        final newTrailerList = await _movieRepository.getTrailerById(movieId: event.movieId);
        return emit(state.copyWith(
          status: MovieDetailStatus.success,
          trailerList: newTrailerList,
          isLoading: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: MovieDetailStatus.failure));
    }
  }

  Future<void> _onCastFetched(CastListFetched event, Emitter<MovieDetailState> emit) async {
    try {
      if (state.status == MovieDetailStatus.initial) {
        final newCastList = await _movieRepository.getCastListById(movieId: event.movieId);
        return emit(state.copyWith(
          status: MovieDetailStatus.success,
          castList: newCastList,
          isLoading: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: MovieDetailStatus.failure));
    }
  }
}
