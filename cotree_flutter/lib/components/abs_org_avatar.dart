import 'package:flutter/material.dart';

class AbsOrgAvatar extends StatelessWidget {
  final double radius;
  final String avatarUrl;
  const AbsOrgAvatar(
      {super.key, required this.radius, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (avatarUrl.isNotEmpty) {
      final uri = Uri.parse(avatarUrl);
      imageProvider = NetworkImage(uri.toString());
    } else {
      imageProvider = const AssetImage("assets/default_org.jpg");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover))),
      ],
    );
  }
}
