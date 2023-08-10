import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PTwoAction extends StatelessWidget {
  final void Function()? editPost;
  final void Function()? deletePost;
  final void Function()? cancelAction;

  const PTwoAction({
    super.key,
    this.editPost,
    this.deletePost,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Center(
            child: Text('txt_edit_post'.tr.capitalizeFirst!),
          ),
          onTap: editPost,
        ),
        const Divider(),
        ListTile(
          title: Center(
            child: Text('txt_delete_post'.tr.capitalizeFirst!),
          ),
          onTap: deletePost,
        ),
        const Divider(),
        ListTile(
          title: Center(
            child: Text('txt_cancel'.tr.capitalizeFirst!),
          ),
          onTap: cancelAction,
        ),
      ],
    );
  }
}
