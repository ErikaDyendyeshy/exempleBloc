import 'package:bloc_project/data/model/movie_model.dart';

class MovieListResponse {
  final List<MovieModel> movieList;
  final int totalCount;

  MovieListResponse({
  required List<dynamic> movieListJson,
    this.totalCount = 0,
  }) : movieList = movieListJson.map((dynamic json) => MovieModel.fromJson(json)).toList();
}
