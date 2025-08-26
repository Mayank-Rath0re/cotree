import 'package:flutter/material.dart';

class AbsAvatar extends StatelessWidget {
  final double radius;
  final String avatarUrl;

  const AbsAvatar({
    super.key,
    required this.radius,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (avatarUrl.isNotEmpty) {
      final uri = Uri.parse(avatarUrl);
      imageProvider = NetworkImage(uri.toString());
    } else {
      imageProvider = const AssetImage("assets/avatar.jpg");
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: imageProvider,
    );
  }
}
