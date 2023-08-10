import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'new_email_request.g.dart';

@JsonSerializable(createFactory: false)
class NewEmailRequest extends ToJsonInterface {
  @JsonKey(name: 'new_email')
  final String newEmail;
  final String code;

  NewEmailRequest({
    required this.newEmail,
    required this.code,
  });

  @override
  Map<String, dynamic> toJson() => _$NewEmailRequestToJson(this);
}
