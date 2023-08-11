import 'package:bloc_project/data/data_source/movie_api_service.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/data/model/trailer_model.dart';
import 'package:get_it/get_it.dart';

class MovieRepository {
  final MovieApiService _movieApiService = GetIt.instance.get<MovieApiService>();

  Future<List<MovieModel>> getMovieList([int startIndex = 1]) {
    return _movieApiService.getMovieList(page: startIndex);
  }

  Future<MovieModel> getMovieById({required int movieId}) {
    return _movieApiService.getMovieById(movieId: movieId);
  }

  Future<List<TrailerModel>> getTrailerById({required int movieId}) {
    return _movieApiService.getTrailerById(movieId: movieId);
  }
}
