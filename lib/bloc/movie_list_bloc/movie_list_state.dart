part of 'movie_list_bloc.dart';

enum MovieListStatus { initial, success, failure }

class MovieListState extends Equatable {
  final MovieListStatus status;
  final List<MovieModel> movieList;
  final bool hasReachedMax;
  final bool isLoading;
  final int currentPage;

   const MovieListState({
    this.status = MovieListStatus.initial,
    this.movieList = const <MovieModel>[],
    this.hasReachedMax = false,
    this.isLoading = false,
    this.currentPage = 1,
  });

  MovieListState copyWith(
      {MovieListStatus? status, List<MovieModel>? movieList, bool? hasReachedMax, bool? isLoading, int? currentPage}) {
    return MovieListState(
      status: status ?? this.status,
      movieList: movieList ?? this.movieList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'MovieListState {status: $status, hasReachedMax: $hasReachedMax, movieList: ${movieList.length}, isLoading: $isLoading currentPage: $currentPage';
  }

  @override
  List<Object?> get props => [status, hasReachedMax, movieList, currentPage, isLoading];
}
