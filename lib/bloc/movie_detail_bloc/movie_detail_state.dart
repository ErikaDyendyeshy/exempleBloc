part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, success, failure }

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final MovieModel? movie;
  final List<TrailerModel>? trailerList;
  final bool isLoading;

  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.movie,
    this.trailerList = const <TrailerModel>[],
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        status,
        movie,
        isLoading,
        trailerList,
      ];

  String toSting() {
    return 'MovieDetailState {status: $status, movie: $movie, trailerList: $trailerList, isLoading: $isLoading}';
  }

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieModel? movie,
    List<TrailerModel>? trailerList,
    bool? isLoading,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      trailerList: trailerList ?? this.trailerList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
