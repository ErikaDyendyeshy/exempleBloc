import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'search_request.g.dart';

@JsonSerializable(createFactory: false)
class SearchRequest extends ToJsonInterface {
  final String request;

  SearchRequest({
    required this.request,
  });

  @override
  Map<String, dynamic> toJson() => _$SearchRequestToJson(this);
}
