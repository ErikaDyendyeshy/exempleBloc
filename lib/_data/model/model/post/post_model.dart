import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
import 'package:parallel/util/mixin/change_data_format_mixin.dart';

part 'post_model.g.dart';

@JsonSerializable(includeIfNull: true)
class PostModel extends ToJsonInterface with ChangeDataFormat {
  @JsonKey(name: 'likes_amount')
  late int likesAmount;
  @JsonKey(name: 'comments_amount')
  late int commentsAmount;
  final String id;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  @JsonKey(name: 'date_updated')
  final String dateUpdated;
  final String text;
  @JsonKey(name: 'media_url')
  final String mediaUrl;
  final int type;
  @JsonKey(name: 'nft_link')
  final String nftLink;
  @JsonKey(name: 'user_id')
  final String userId;
  final String username;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'liked_by_me')
  late bool isLiked;

  PostModel({
    required this.isLiked,
    required this.likesAmount,
    required this.commentsAmount,
    required this.id,
    required this.dateCreated,
    required this.dateUpdated,
    required this.text,
    required this.mediaUrl,
    required this.type,
    required this.nftLink,
    required this.userId,
    required this.username,
    required this.avatarUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  String get createdOnString => created(dateCreated);

  bool get isVideoPost => type == 2;
}
