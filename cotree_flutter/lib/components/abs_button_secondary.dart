import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsButtonSecondary extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final double fontSize;
  final bool roundedBorder;

  const AbsButtonSecondary({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.fontSize = 16,
    this.roundedBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: theme.secondaryColor, // lighter brown for secondary
        foregroundColor: theme.contrastColor, // off-white text/icons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedBorder ? 24 : 8),
          side: BorderSide(
            width: 1,
            color: theme.mainColor.withOpacity(0.5), // subtle outline
          ),
        ),
        textStyle: TextStyle(fontSize: fontSize),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                size: fontSize + 2,
                color: theme.headColor, // golden accent for icons
              ),
              child: icon!,
            ),
            const SizedBox(width: 8),
          ],
          AbsText(
            displayString: text,
            fontSize: fontSize,
            bold: true,
            headColor: false, // let contrastColor handle text color
          ),
        ],
      ),
    );
  }
}
