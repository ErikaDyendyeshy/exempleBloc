// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      isLiked: json['liked_by_me'] as bool,
      likesAmount: json['likes_amount'] as int,
      commentsAmount: json['comments_amount'] as int,
      id: json['id'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      dateUpdated: json['date_updated'] as String,
      text: json['text'] as String,
      mediaUrl: json['media_url'] as String,
      type: json['type'] as int,
      nftLink: json['nft_link'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'likes_amount': instance.likesAmount,
      'comments_amount': instance.commentsAmount,
      'id': instance.id,
      'date_created': instance.dateCreated.toIso8601String(),
      'date_updated': instance.dateUpdated,
      'text': instance.text,
      'media_url': instance.mediaUrl,
      'type': instance.type,
      'nft_link': instance.nftLink,
      'user_id': instance.userId,
      'username': instance.username,
      'avatar_url': instance.avatarUrl,
      'liked_by_me': instance.isLiked,
    };
