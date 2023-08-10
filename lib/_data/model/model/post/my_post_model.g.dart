// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPostModel _$MyPostModelFromJson(Map<String, dynamic> json) => MyPostModel(
      isLiked: json['liked_by_me'] as bool,
      likesAmount: json['likes_amount'] as int,
      commentsAmount: json['comments_amount'] as int,
      id: json['id'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      dateUpdated: DateTime.parse(json['date_updated'] as String),
      text: json['text'] as String,
      mediaUrl: json['media_url'] as String,
      type: json['type'] as int,
      nftLink: json['nft_link'] as String,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$MyPostModelToJson(MyPostModel instance) =>
    <String, dynamic>{
      'likes_amount': instance.likesAmount,
      'comments_amount': instance.commentsAmount,
      'id': instance.id,
      'date_created': instance.dateCreated.toIso8601String(),
      'date_updated': instance.dateUpdated.toIso8601String(),
      'text': instance.text,
      'media_url': instance.mediaUrl,
      'type': instance.type,
      'nft_link': instance.nftLink,
      'user_id': instance.userId,
      'liked_by_me': instance.isLiked,
    };