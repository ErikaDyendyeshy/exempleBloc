import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class PProfileSkeleton extends StatelessWidget {
  const PProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 84,
                        height: 84,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 80,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 32,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 32,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: 6,
                    padding: EdgeInsets.zero,
                    lineStyle: SkeletonLineStyle(
                      // randomLength: true,
                      height: 16,
                      borderRadius: BorderRadius.circular(5),
                      minLength: Get.width / 2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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
