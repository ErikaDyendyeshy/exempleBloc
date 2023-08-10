import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/gallery_model.dart';
import 'package:parallel/_data/model/model/post/my_post_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/profile/widget/gallery_profile_widget.dart';
import 'package:parallel/widget/profile/widget/post_profile_widget.dart';

class PProfileWidget extends StatelessWidget {
  final TabController? tapController;
  final String avatarUrl;
  final String userName;
  final String country;
  final String followers;
  final String following;
  final String aboutMe;
  final List<MyPostModel> postList;
  final List<GalleryModel> galleryList;
  final Function() firstButton;
  final Function() secondButton;
  final Function() openShowMoreAboutMe;
  final Function() loadMorePages;
  final Function()? openConnectionList;
  final Function(String postId)? openDetailPage;
  final bool otherProfile;
  final bool isFollowing;
  final bool loading;

  const PProfileWidget({
    super.key,
    required this.tapController,
    required this.avatarUrl,
    required this.userName,
    required this.country,
    required this.followers,
    required this.following,
    required this.secondButton,
    required this.firstButton,
    required this.aboutMe,
    this.openConnectionList,
    required this.openShowMoreAboutMe,
    required this.postList,
    required this.galleryList,
    required this.loadMorePages,
    this.otherProfile = false,
    this.isFollowing = false,
    this.loading = false,
    this.openDetailPage,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _header(),
                _buttons(),
                _aboutMe(),
              ],
            ),
          ),
          SliverAppBar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            pinned: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 15),
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tapController,
                  indicatorColor: Get.theme.colorScheme.onPrimary,
                  labelStyle: Get.theme.textTheme.labelLarge,
                  unselectedLabelColor: Get.theme.colorScheme.onSurface,
                  unselectedLabelStyle: Get.theme.textTheme.titleSmall,
                  tabs: [
                    _tabItem('txt_posts'.tr),
                    _tabItem('txt_gallery'.tr),
                  ],
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tapController,
        children: [
          postList.isEmpty || loading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 70),
                    const PSVGIcon(icon: 'icon_write'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'txt_your_profile_is_waiting_for_your_first_post'.tr.capitalizeFirst!,
                        style: Get.theme.textTheme.titleLarge!.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : PostProfileWidget(
                  postList: postList,
                  openDetailPost: (postId) => openDetailPage!(postId),
                ),
          galleryList.isEmpty || loading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 70),
                    const PSVGIcon(icon: 'icon_image'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'txt_here_will_be_displayed_media_that_you_used_in_posts'
                            .tr
                            .capitalizeFirst!,
                        style: Get.theme.textTheme.titleLarge!.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: GalleryProfileWdiget(
                    galleryList: galleryList,
                    openDetailPost: (postId) => openDetailPage!(postId),
                    loadMorePages: () => loadMorePages(),
                  ),
                )
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: Column(
        children: [
          if (otherProfile == true) const SizedBox(height: 20),
          Row(
            children: [
              PAvatarWidget(
                height: 80,
                width: 80,
                avatarUrl: avatarUrl,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    maxLines: 1,
                    style: Get.theme.textTheme.headlineMedium,
                  ),
                  country.isNotEmpty ? const SizedBox(height: 5) : const SizedBox.shrink(),
                  country.isNotEmpty
                      ? Text(
                          country,
                          maxLines: 1,
                          style: Get.theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 15),
                  IntrinsicHeight(
                    child: GestureDetector(
                      onTap: openConnectionList,
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: followers,
                              style: Get.theme.textTheme.headlineMedium,
                              children: <InlineSpan>[
                                const WidgetSpan(
                                  child: SizedBox(width: 5),
                                ),
                                TextSpan(
                                  text: 'txt_followers'.tr,
                                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 30,
                            color: Get.theme.colorScheme.surface,
                            thickness: 2,
                          ),
                          RichText(
                            text: TextSpan(
                              text: following,
                              style: Get.theme.textTheme.headlineMedium,
                              children: <InlineSpan>[
                                const WidgetSpan(
                                  child: SizedBox(width: 5),
                                ),
                                TextSpan(
                                  text: 'txt_following'.tr,
                                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingScreen,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: PButtonWidget(
              loading: loading,
              onPressed: firstButton,
              height: 32,
              colorTrascparent: isFollowing ? true : false,
              text: isFollowing
                  ? 'txt_unfollow'.tr.capitalizeFirst!
                  : otherProfile
                      ? 'txt_follow'.tr.capitalizeFirst!
                      : 'txt_create_post'.tr,
              textStyle: Get.theme.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isFollowing
                      ? Get.theme.colorScheme.secondary
                      : Get.theme.colorScheme.background),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: PButtonWidget(
              colorTrascparent: true,
              height: 32,
              text: otherProfile ? 'txt_send_message'.tr.capitalizeFirst! : 'txt_edit_profile'.tr,
              onPressed: secondButton,
              textStyle: Get.theme.textTheme.labelLarge!.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: GestureDetector(
        onTap: openShowMoreAboutMe,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (aboutMe != '')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'txt_about_me'.tr.toUpperCase(),
                    style: Get.theme.textTheme.titleLarge,
                  ),
                  Text(
                    'txt_show_more'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.titleLarge,
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Text(
              aboutMe,
              style: Get.theme.textTheme.labelLarge!.copyWith(fontSize: 14),
              textAlign: TextAlign.left,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text.capitalizeFirst!,
        style: Get.theme.textTheme.labelLarge!.copyWith(fontSize: 14),
      ),
    );
  }
}
