import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsListtileButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Icon? icon;
  final double fontSize;
  const AbsListtileButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize = 16,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Provider.of<ThemeProvider>(context).contrastColor,
        backgroundColor: Provider.of<ThemeProvider>(context).mainColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Provider.of<ThemeProvider>(context).contrastColor),
          borderRadius:
              BorderRadiusGeometry.circular(16), // Adjust based on the image
        ),
        textStyle: TextStyle(fontSize: fontSize),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[const SizedBox(width: 5), icon!],
          const SizedBox(width: 8),
          AbsText(
            displayString: text,
            fontSize: fontSize,
            bold: true,
          ),
        ],
      ),
    );
  }
}
