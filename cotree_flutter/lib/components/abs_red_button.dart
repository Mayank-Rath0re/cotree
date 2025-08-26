import 'package:flutter/material.dart';

class AbsRedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double fontSize;
  final Icon? icon;
  final bool roundedBorder;
  const AbsRedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.fontSize = 16,
      this.icon,
      this.roundedBorder = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 156, 10, 0),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadiusGeometry.circular(roundedBorder ? 25 : 8))),
      child: Text(text,
          style: TextStyle(
              color: const Color(0xFFFDF8F4),
              fontSize: fontSize,
              fontWeight: FontWeight.bold)),
    );
  }
}
