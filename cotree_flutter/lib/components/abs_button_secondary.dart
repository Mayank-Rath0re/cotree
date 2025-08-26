import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsButtonSecondary extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Widget? icon;
  final bool roundedBorder;
  final double fontSize;
  const AbsButtonSecondary({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.roundedBorder = false,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeProvider>(context).headColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: themeColor,
        backgroundColor: Provider.of<ThemeProvider>(context).mainColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.5,
                color: Provider.of<ThemeProvider>(context).contrastColor),
            borderRadius: roundedBorder
                ? BorderRadiusGeometry.circular(24)
                : BorderRadiusGeometry.circular(8)),
        textStyle: TextStyle(fontSize: fontSize),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 5),
          ],
          AbsText(
            displayString: text,
            fontSize: fontSize,
            bold: true,
            headColor: true,
          ),
        ],
      ),
    );
  }
}
