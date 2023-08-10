import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/post/comment_model.dart';
import 'package:parallel/_domain/wrapper/post_detail_wrapper.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/post/post_detail/post_detail_controller.dart';
import 'package:parallel/module/post/post_detail/widget/post_skeleton.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_list_view_widget.dart';
import 'package:parallel/widget/post_widget/post_widget.dart';

class PostDetailScreen extends GetView<PostDetailController> {
  @override
  // ignore: overridden_fields
  late final String tag;
  late final bool isMyPost;

  PostDetailScreen({Key? key}) : super(key: key) {
    final PostDetailWrapper wrapper = Get.arguments as PostDetailWrapper;
    tag = 'post_detail_page_${wrapper.postId}';
    isMyPost = wrapper.isMyPost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text('txt_post'.tr.capitalizeFirst!),
        elevation: 0,
      ),
      body: Obx(
        () => controller.isPostLoading.value ? const PostSkeleton() : _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: PostWidget(
                  post: controller.post,
                  commentsAmount: controller.commentsAmountRx.value,
                  isDetailPost: true,
                  isMyPost: isMyPost,
                ),
              ),
            ];
          },
          body: _comments(),
        ),
        _leaveComment(),
      ],
    );
  }

  Widget _comments() {
    return PListViewWidget(
      onPullToRefresh: () => controller.getCommentsById(reset: true),
      count: controller.commentListRx.length,
      onBuildItem: (int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: _commentItem(controller.commentListRx[index]),
        );
      },
    );
  }

  Widget _commentItem(CommentModel comments) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.openProfile(personId: comments.userId),
                //TODO waiting from back end to return user id, avatar and user name
                child: Row(
                  children: [
                    const PAvatarWidget(
                      height: 40,
                      width: 40,
                      borderRadius: 8,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'User name',
                      style: Get.theme.textTheme.headlineMedium,
                    ), //TODO waiting from backend for user name, user id, user avatar
                  ],
                ),
              ),
              const Spacer(),
              Text(comments.createdOnString),
            ],
          ),
          const SizedBox(height: 8),
          Text(comments.comment),
          const SizedBox(height: 16)
        ],
      ),
    );
  }

  Widget _leaveComment() {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(
              left: horizontalPaddingScreen,
              right: horizontalPaddingScreen,
              top: 20,
              bottom: 35,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              border: Border(
                top: BorderSide(
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  child: PInputTextFieldWidget(
                    onChanged: (value) => controller.checkTextComment(value),
                    controller: controller.commentController,
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => PButtonWidget(
                    disabled: controller.commentTextRx.value.isEmpty,
                    onPressed: () => controller.postComment(),
                    icon: 'icon_send_message',
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
