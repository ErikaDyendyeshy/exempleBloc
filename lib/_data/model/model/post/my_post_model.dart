import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
import 'package:parallel/util/mixin/change_data_format_mixin.dart';

part 'my_post_model.g.dart';

@JsonSerializable(includeIfNull: true)
class MyPostModel extends ToJsonInterface with ChangeDataFormat {
  @JsonKey(name: 'likes_amount')
  late int likesAmount;
  @JsonKey(name: 'comments_amount')
  late int commentsAmount;
  final String id;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  @JsonKey(name: 'date_updated')
  final DateTime dateUpdated;
  final String text;
  @JsonKey(name: 'media_url')
  final String mediaUrl;
  final int type;
  @JsonKey(name: 'nft_link')
  final String nftLink;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'liked_by_me')
  late bool isLiked;

  MyPostModel({
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
  });

  factory MyPostModel.fromJson(Map<String, dynamic> json) =>
      _$MyPostModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyPostModelToJson(this);

  String get createdOnString => created(dateCreated);
}
