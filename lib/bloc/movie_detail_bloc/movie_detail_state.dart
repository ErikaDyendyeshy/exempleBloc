part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, success, failure }

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final MovieModel? movie;
  final List<CastModel>? castList;
  final List<TrailerModel>? trailerList;
  final bool isLoading;

  MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.movie,
    this.trailerList = const <TrailerModel>[],
    this.castList = const <CastModel>[],
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        status,
        movie,
        isLoading,
        trailerList,
        castList,
      ];

  String toSting() {
    return 'MovieDetailState {status: $status, movie: $movie, trailerList: $trailerList, castModel: $castList, isLoading: $isLoading}';
  }

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieModel? movie,
    List<TrailerModel>? trailerList,
    List<CastModel>? castList,
    bool? isLoading,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      trailerList: trailerList ?? this.trailerList,
      castList: castList ?? this.castList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
