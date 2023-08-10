import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/short_person_model_temp/short_person_model_temp.dart';

class UserSearchListResponse extends ListModel<ShortPersonModel> {
  UserSearchListResponse({
    required List<ShortPersonModel> data,
    required Pagination pagination,
  }) : super(
          data: data,
          pagination: pagination,
        );

  factory UserSearchListResponse.fromJson(Map<String, dynamic> json) {
    return UserSearchListResponse(
      data: List<ShortPersonModel>.from(
          json['data'].map((x) => ShortPersonModel.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
