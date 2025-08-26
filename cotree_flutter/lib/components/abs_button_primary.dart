import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsButtonPrimary extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double fontSize;
  final bool roundedBorder;
  final Icon? icon;
  final bool isLoading;
  const AbsButtonPrimary(
      {super.key,
      required this.onPressed,
      required this.text,
      this.roundedBorder = false,
      this.fontSize = 16,
      this.icon,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: Provider.of<ThemeProvider>(context).headColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadiusGeometry.circular(roundedBorder ? 25 : 8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 5),
          ],
          if (!isLoading) ...[
            Text(text,
                style: TextStyle(
                    color: const Color(0xFFFDF8F4),
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold)),
          ] else ...[
            const Center(
              child: CircularProgressIndicator(
                color: const Color(0xFFFDF8F4),
              ),
            )
          ],
        ],
      ),
    );
  }
}
