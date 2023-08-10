import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '__.dart';

class PChooseTypeMedia extends StatelessWidget {
  final void Function()? getImage;
  final void Function()? getVideo;

  const PChooseTypeMedia({
    super.key,
    this.getImage,
    this.getVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const PSVGIcon(
            icon: 'icon_image_2',
          ),
          title: Text('txt_upload_photo'.tr.capitalizeFirst!),
          onTap: getImage,
        ),
        const Divider(),
        ListTile(
          leading: const PSVGIcon(
            icon: 'icon_video',
          ),
          title: Text('txt_upload_video'.tr.capitalizeFirst!),
          onTap: getVideo,
        ),
        const Divider(),
      ],
    );
  }
}
