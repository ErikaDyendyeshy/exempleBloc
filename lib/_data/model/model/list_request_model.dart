import 'package:parallel/_data/model/model/request_model.dart';

class ListRequestModel {
  final List<RequestModel> listRequest;

  ListRequestModel({
    required this.listRequest,
  });

  factory ListRequestModel.fromJson(List<dynamic> json) {
    final list = json.map((item) => RequestModel.fromJson(item)).toList();
    return ListRequestModel(listRequest: list);
  }
}
