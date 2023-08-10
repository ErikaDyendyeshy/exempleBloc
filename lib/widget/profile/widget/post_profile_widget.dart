import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/post/my_post_model.dart';
import 'package:parallel/widget/p_image_widget.dart';
import 'package:parallel/widget/profile/widget/video_item_widget/video_item_widget.dart';

class PostProfileWidget extends StatelessWidget {
  final List<MyPostModel> postList;
  final Function(String postId) openDetailPost;
  const PostProfileWidget({
    required this.postList,
    required this.openDetailPost,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double itemWidth = (screenWidth - 4) / 3;

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      childAspectRatio: 1,
      children: List.generate(
        postList.length,
        (index) => _itemList(
          postList[index],
          itemWidth,
        ),
      ),
    );
  }

  Widget _itemList(MyPostModel post, double itemWidth) {
    return post.type == 1
        ? GestureDetector(
            onTap: () => openDetailPost(post.id),
            child: PImageWidget(
              url: post.mediaUrl,
              width: Get.width,
              height: Get.height,
            ),
          )
        : VideoItemWidget(
            media: post,
            openDetailPost: (_) => openDetailPost(post.id),
          );
  }
}
