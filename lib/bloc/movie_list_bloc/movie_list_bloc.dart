import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/domain/repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_list_event.dart';

part 'movie_list_state.dart';

const throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository = GetIt.instance.get<MovieRepository>();

  MovieListBloc() : super( const MovieListState()) {
    on<MovieListFetched>(
      _onMovieListFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onMovieListFetched(MovieListFetched event, Emitter<MovieListState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovieListStatus.initial) {
        final newMovieList = await _movieRepository.getMovieList();
        return emit(
          state.copyWith(
            status: MovieListStatus.success,
            movieList: newMovieList,
            hasReachedMax: false,
            currentPage: state.currentPage + 1,
          ),
        );
      }

      final newMovieList = await _movieRepository.getMovieList(state.currentPage);
      newMovieList.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MovieListStatus.success,
                movieList: List.of(state.movieList)..addAll(newMovieList),
                hasReachedMax: false,
                currentPage: state.currentPage + 1,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MovieListStatus.failure));
    }
  }
}
