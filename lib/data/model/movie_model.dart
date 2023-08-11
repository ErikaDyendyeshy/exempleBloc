import 'package:bloc_project/data/model/genre_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  @JsonKey(name: 'vote_average')
  final double rating;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(defaultValue: 0)
  final int runtime;
  @JsonKey(defaultValue: '')
  final String overview;
  @JsonKey(name: 'genres', defaultValue: [])
  final List<GenreModel> genreList;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.releaseDate,
    required this.posterPath,
    required this.runtime,
    required this.genreList,
    required this.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

}
