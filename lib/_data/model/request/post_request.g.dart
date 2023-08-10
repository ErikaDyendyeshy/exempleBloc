// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostRequest _$PostRequestFromJson(Map<String, dynamic> json) => PostRequest(
      text: json['text'] as String,
      mediaUrl: json['media_url'] as String?,
      type: json['type'] as int,
      nftLink: json['nft_link'] as String?,
    );

Map<String, dynamic> _$PostRequestToJson(PostRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'media_url': instance.mediaUrl,
      'type': instance.type,
      'nft_link': instance.nftLink,
    };
