import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PImageWidget extends StatelessWidget {
  final BoxFit fit;
  final double width;
  final double height;
  final String url;

  const PImageWidget({
    super.key,
    this.fit = BoxFit.cover,
    this.width = 100,
    this.height = 100,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return url.startsWith('https')
        ? Image.network(
            url,
            height: height,
            width: width,
            fit: fit,
            errorBuilder: (context, exception, stackTrace) {
              return _errorSkeleton();
            },
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) return child;
              return _errorSkeleton();
            },
          )
        : Image.file(
            File(url),
            height: height,
            width: width,
            fit: fit,
            errorBuilder: (context, exception, stackTrace) {
              return _errorSkeleton();
            },
          );
  }

  Widget _errorSkeleton() {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        shape: BoxShape.rectangle,
        height: height,
        width: width,
      ),
    );
  }
}
