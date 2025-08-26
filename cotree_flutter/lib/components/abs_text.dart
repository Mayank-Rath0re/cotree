import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsText extends StatelessWidget {
  final String displayString;
  final bool align;
  final double fontSize;
  final bool headColor;
  final bool bold;
  const AbsText(
      {super.key,
      required this.displayString,
      required this.fontSize,
      this.align = false,
      this.headColor = false,
      this.bold = false});

  @override
  Widget build(BuildContext context) {
    Color color = headColor
        ? Provider.of<ThemeProvider>(context).headColor
        : Provider.of<ThemeProvider>(context).contrastColor;
    return Text(
        textAlign: align ? TextAlign.center : TextAlign.start,
        displayString,
        softWrap: true,
        overflow: TextOverflow.clip,
        //overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal));
  }
}
