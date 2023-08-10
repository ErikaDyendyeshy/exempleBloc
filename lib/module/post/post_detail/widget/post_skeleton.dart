import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class PostSkeleton extends StatelessWidget {
  const PostSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 40,
                        height: 40,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 20,
                        width: 100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: double.infinity,
                    height: 220,
                    maxHeight: MediaQuery.of(context).size.height / 3,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 15,
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 15,
                        width: 50,
                      ),
                    ),
                    Spacer(),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 15,
                        width: 80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: 10,
                    lineStyle: SkeletonLineStyle(
                      height: 15,
                      borderRadius: BorderRadius.circular(8),
                      width: Get.width,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Flexible(
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: Get.width,
                height: Get.height,
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
