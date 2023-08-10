import 'package:flutter/material.dart';

class PAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final double height;
  final double width;
  final double borderRadius;

  const PAvatarWidget({
    super.key,
    this.avatarUrl,
    required this.height,
    required this.width,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: avatarUrl != null && avatarUrl != ""
          ? _avatar()
          : _preview(),
    );
  }

  Widget _avatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image(
          image: NetworkImage(
            avatarUrl!,
          ),
          fit: BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) {
            return _preview();
          }),
    );
  }

  Widget _preview() {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/image/default_avatar.png')
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
