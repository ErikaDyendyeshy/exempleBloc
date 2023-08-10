import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
import 'package:parallel/util/mixin/change_data_format_mixin.dart';

part 'gallery_model.g.dart';

@JsonSerializable(includeIfNull: true)
class GalleryModel extends ToJsonInterface with ChangeDataFormat {
  final String id;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  @JsonKey(name: 'media_url')
  final String mediaUrl;
  final int type;
  @JsonKey(name: 'nft_link')
  final String nftLink;

  GalleryModel({
    required this.id,
    required this.dateCreated,
    required this.mediaUrl,
    required this.type,
    required this.nftLink,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);

  String get createdOnString => created(dateCreated);
}
