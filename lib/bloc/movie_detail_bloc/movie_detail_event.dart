part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailFetched extends MovieDetailEvent {
  final int movieId;

  const MovieDetailFetched(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class TrailerListFetched extends MovieDetailEvent {
  final int movieId;

  const TrailerListFetched(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class CastListFetched extends MovieDetailEvent {
  final int movieId;

  const CastListFetched(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
