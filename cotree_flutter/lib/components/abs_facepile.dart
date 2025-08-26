import 'package:cotree_flutter/components/abs_text.dart';
import 'package:face_pile/face_pile.dart';
import 'package:flutter/material.dart';

class AbsFacepile extends StatelessWidget {
  final List<String?> images;
  final double radius;
  final double spacing;
  const AbsFacepile(
      {super.key, required this.images, this.radius = 26, this.spacing = 40});

  @override
  Widget build(BuildContext context) {
    int additionalCount = 0;
    List<String?> buildImages = images;
    if (images.length > 5) {
      additionalCount = images.length - 5;
      buildImages = images.sublist(0, 5);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FacePile(
            radius: radius,
            space: spacing,
            images: buildImages.map<ImageProvider<Object>>((image) {
              if (image != null && image != "") {
                return NetworkImage(image);
              } else {
                return const AssetImage('assets/avatar.jpg');
              }
            }).toList(),
          ),
          if (additionalCount > 5) ...[
            const SizedBox(width: 8),
            AbsText(displayString: "+ $additionalCount more", fontSize: 18)
          ]
        ],
      ),
    );
  }
}
