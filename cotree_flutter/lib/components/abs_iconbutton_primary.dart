import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsIconButtonPrimary extends StatelessWidget {
  final Function()? onPressed;
  final Icon icon;
  const AbsIconButtonPrimary({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 1,
          foregroundColor: const Color(0xFFFDF8F4),
          backgroundColor: Provider.of<ThemeProvider>(context).headColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8))),
      icon: icon,
    );
  }
}
