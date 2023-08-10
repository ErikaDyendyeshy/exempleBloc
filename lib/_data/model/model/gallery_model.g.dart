// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) => GalleryModel(
      id: json['id'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      mediaUrl: json['media_url'] as String,
      type: json['type'] as int,
      nftLink: json['nft_link'] as String,
    );

Map<String, dynamic> _$GalleryModelToJson(GalleryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date_created': instance.dateCreated.toIso8601String(),
      'media_url': instance.mediaUrl,
      'type': instance.type,
      'nft_link': instance.nftLink,
    };
