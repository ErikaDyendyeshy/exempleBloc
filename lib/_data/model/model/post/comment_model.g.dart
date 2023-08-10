// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      comment: json['comment'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      commentId: json['id'] as String,
      userId: json['user'] as String,
      postId: json['post'] as String,
      dateUpdated: DateTime.parse(json['date_updated'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.commentId,
      'post': instance.postId,
      'user': instance.userId,
      'comment': instance.comment,
      'date_created': instance.dateCreated.toIso8601String(),
      'date_updated': instance.dateUpdated.toIso8601String(),
    };
