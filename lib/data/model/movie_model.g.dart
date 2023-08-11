// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      rating: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] as String,
      posterPath: json['poster_path'] as String,
      runtime: json['runtime'] as int? ?? 0,
      genreList: (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      overview: json['overview'] as String? ?? '',
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'vote_average': instance.rating,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
      'runtime': instance.runtime,
      'overview': instance.overview,
      'genres': instance.genreList,
    };
