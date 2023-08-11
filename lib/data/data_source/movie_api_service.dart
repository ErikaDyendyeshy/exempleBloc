import 'dart:convert';
import 'dart:developer';

import 'package:bloc_project/const.dart';
import 'package:bloc_project/data/model/movie_model.dart';
import 'package:bloc_project/data/model/trailer_model.dart';
import 'package:http/http.dart' as http;

class MovieApiService {
  Future<List<MovieModel>> getMovieList({
    required int page,
  }) async {
    final url = Uri.parse('$apiUrl/3/movie/top_rated');
    final query = {
      'page': page.toString(),
      'api_key': apiKey,
      'language': 'uk-UA',
    };

    final response = await http.get(
      url.replace(
        queryParameters: query,
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<MovieModel>.from(
        data['results'].map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw Exception('Oops! Failed to load movies');
    }
  }

  Future<MovieModel> getMovieById({required int movieId}) async {
    final url = Uri.parse('$apiUrl/3/movie/$movieId');
    final query = {
      'api_key': apiKey,
      'language': 'uk-UA',
    };
    final response = await http.get(url.replace(queryParameters: query));
    if (response.statusCode == 200) {
      print(url.replace(
        queryParameters: query,
      ));
      log(response.body);
      return MovieModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Oops! Failed to load movies');
    }
  }

  Future<List<TrailerModel>> getTrailerById({required int movieId}) async {
    final url = Uri.parse('$apiUrl/3/movie/$movieId/videos');
    final query = {
      'api_key': apiKey,
      'language': 'en-EN',

    };

    final response = await http.get(url.replace(queryParameters: query));

    if (response.statusCode == 200) {
      print(url.replace(
        queryParameters: query,
      ));
      final data = jsonDecode(response.body);
      log(response.body);
      return List<TrailerModel>.from(
        data['results'].map(
          (movie) => TrailerModel.fromJson(movie),
        ),

      );
    } else {
      throw Exception('Oops! Failed to load movies');
    }
  }
}
