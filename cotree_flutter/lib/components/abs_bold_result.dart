import 'package:cotree_flutter/components/abs_text.dart';
import 'package:flutter/material.dart';

class AbsBoldResult extends StatelessWidget {
  final String field;
  final String value;
  final bool spaceBetween;
  final double fontSize;
  const AbsBoldResult(
      {super.key,
      required this.field,
      required this.value,
      this.fontSize = 16,
      this.spaceBetween = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: spaceBetween
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        AbsText(
            displayString: "$field:  ",
            fontSize: fontSize,
            bold: true,
            headColor: true),
        AbsText(displayString: value, fontSize: fontSize - 1)
      ],
    );
  }
}
