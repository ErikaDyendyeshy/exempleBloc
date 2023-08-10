import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class PAnyLinkWidget extends StatelessWidget {
  final String link;
  final LinkPreview? linkPreview;
  final Function()? onTap;
  final Function()? openWeb;
  final bool isCreatedLink;
  final double? height;

  const PAnyLinkWidget({
    super.key,
    required this.link,
    this.onTap,
    this.openWeb,
    this.linkPreview,
    this.isCreatedLink = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return isCreatedLink
        ? AnyLinkPreview(
            link: link,
            displayDirection: UIDirection.uiDirectionVertical,
            cache: const Duration(days: 1),
            backgroundColor: Get.theme.colorScheme.background,
            previewHeight: height ?? (Get.width / 3) * 2 - 32,
            // titleStyle: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            // bodyStyle: Get.textTheme.bodyMedium,
            errorWidget: SizedBox(
              width: Get.width,
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'txt_something_went_wrong'.tr,
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: Get.theme.colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'txt_incorrect_url_link'.tr,
                    style: Get.textTheme.bodyLarge!.copyWith(color: Get.theme.colorScheme.error),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: openWeb,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Get.theme.dividerColor),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Column(
                children: [
                  Container(
                    height: height ?? (Get.width / 3) * 2 - 32,
                    width: Get.width,
                    color: Get.theme.colorScheme.background,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        linkPreview!.image,
                      ),
                      errorBuilder: (context, exception, stackTrace) {
                        return SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.rectangle,
                            height: 100,
                            width: Get.width,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    linkPreview!.title,
                    style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    linkPreview!.description,
                    style: Get.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
  }
}

class LinkPreview {
  final String image;
  final String title;
  final String description;
  final String video;

  LinkPreview({
    required this.image,
    required this.title,
    required this.description,
    required this.video,
  });
}
