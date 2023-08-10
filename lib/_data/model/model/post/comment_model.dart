import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/util/mixin/change_data_format_mixin.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel with ChangeDataFormat {
  @JsonKey(name: 'id')
  final String commentId;
  @JsonKey(name: 'post')
  final String postId;
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'comment')
  final String comment;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  @JsonKey(name: 'date_updated')
  final DateTime dateUpdated;

  CommentModel({
    required this.comment,
    required this.dateCreated,
    required this.commentId,
    required this.userId,
    required this.postId,
    required this.dateUpdated,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  String get createdOnString => created(dateCreated);
}
