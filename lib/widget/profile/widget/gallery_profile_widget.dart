import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/gallery_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_image_widget.dart';
import 'package:parallel/widget/p_list_view_widget.dart';
import 'package:parallel/widget/profile/widget/video_item_widget/video_item_widget.dart';

class GalleryProfileWdiget extends StatelessWidget {
  final List<GalleryModel> galleryList;
  final Function() loadMorePages;
  final Function(String postId) openDetailPost;

  const GalleryProfileWdiget({
    required this.galleryList,
    required this.openDetailPost,
    required this.loadMorePages,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double itemWidth = (screenWidth - 4) / 2.5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _imageList(itemWidth),
          const SizedBox(height: 15),
          _videoList(itemWidth),
          const SizedBox(height: 15),
          _nftList(itemWidth),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _imageList(double itemWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'txt_photos'.tr.capitalizeFirst!,
              style: Get.theme.textTheme.headlineMedium,
            ),
            const Spacer(),
            const PSVGIcon(icon: 'icon_arrow_right_2'),
          ],
        ),
        PListViewWidget(
          primary: false,
          onEndOfPage: () => loadMorePages(),
          isRevers: true,
          count: galleryList.length,
          height: 200,
          scrollDirection: Axis.horizontal,
          onBuildItem: (index) => galleryList[index].type == 1
              ? _itemImageList(galleryList[index], itemWidth)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _videoList(double itemWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'txt_videos'.tr.capitalizeFirst!,
              style: Get.theme.textTheme.headlineMedium,
            ),
            const Spacer(),
            const PSVGIcon(icon: 'icon_arrow_right_2'),
          ],
        ),
        PListViewWidget(
          primary: false,
          isRevers: true,
          count: galleryList.length,
          height: 200,
          scrollDirection: Axis.horizontal,
          onBuildItem: (index) => galleryList[index].type == 2
              ? _itemVideoList(galleryList[index], itemWidth)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _nftList(double itemWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'txt_nft'.tr.capitalize!,
              style: Get.theme.textTheme.headlineMedium,
            ),
            const Spacer(),
            const PSVGIcon(icon: 'icon_arrow_right_2'),
          ],
        ),
        PListViewWidget(
          primary: false,
          isRevers: true,
          count: galleryList.length,
          height: 200,
          scrollDirection: Axis.horizontal,
          onBuildItem: (index) => galleryList[index].type == 4
              ? _itemNftList(galleryList[index], itemWidth)
              : const SizedBox.shrink(), //TODO cannot test no nft provided
        ),
      ],
    );
  }

  Widget _itemNftList(GalleryModel gallery, double itemWidth) {
    return Row(
      children: [
        PImageWidget(
          url: gallery.mediaUrl,
          width: itemWidth,
          height: itemWidth,
        ),
        const SizedBox(width: 10)
      ],
    );
  }

  Widget _itemVideoList(GalleryModel gallery, double itemWidth) {
    return SizedBox(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => openDetailPost(gallery.id),
            child: SizedBox(
              width: itemWidth,
              height: itemWidth,
              child: VideoItemWidget(
                media: gallery,
                openDetailPost: (_) => openDetailPost(gallery.id),
              ),
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
    );
  }

  Widget _itemImageList(GalleryModel gallery, double itemWidth) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => openDetailPost(gallery.id),
          child: PImageWidget(
            url: gallery.mediaUrl,
            width: itemWidth,
            height: itemWidth,
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
