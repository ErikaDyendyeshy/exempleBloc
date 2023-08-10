
class ListModel<T> {
  List<T> data;
  Pagination pagination;

  ListModel({required this.data, required this.pagination});

  factory ListModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonItem) {
    final List<dynamic> dataList = json['data'];
    final List<T> items = dataList.map((item) => fromJsonItem(item)).toList();
    final Pagination pagination = Pagination.fromJson(json['pagination']);
    return ListModel<T>(data: items, pagination: pagination);
  }
}

class Pagination {
  int page;
  bool isLast;

  Pagination({required this.page, required this.isLast});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      isLast: json['is_last'],
    );
  }
}