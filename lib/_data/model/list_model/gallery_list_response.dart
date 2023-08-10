import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/gallery_model.dart';

class GalleryListResponse extends ListModel<GalleryModel> {
  GalleryListResponse({
    required List<GalleryModel> data,
    required Pagination pagination,
  }) : super(
          data: data,
          pagination: pagination,
        );

  factory GalleryListResponse.fromJson(Map<String, dynamic> json) {
    return GalleryListResponse(
      data: List<GalleryModel>.from(
          json['data'].map((x) => GalleryModel.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
