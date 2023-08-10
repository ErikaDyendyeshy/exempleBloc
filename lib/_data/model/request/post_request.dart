import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'post_request.g.dart';

@JsonSerializable()
class PostRequest extends ToJsonInterface {
  final String text;
  @JsonKey(name: 'media_url')
  final String? mediaUrl;
  final int type;
  @JsonKey(name: 'nft_link')
  final String? nftLink;

  PostRequest({
    required this.text,
    required this.mediaUrl,
    required this.type,
    required this.nftLink,
  });

  factory PostRequest.fromJson(Map<String, dynamic> json) => _$PostRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostRequestToJson(this);
}
