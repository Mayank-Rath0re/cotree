import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsMinimalBox extends StatefulWidget {
  final Widget child;
  final bool roundedBorder;
  final int layer;
  const AbsMinimalBox(
      {super.key,
      required this.child,
      this.roundedBorder = false,
      this.layer = 1});

  @override
  State<AbsMinimalBox> createState() => _AbsMinimalBoxState();
}

class _AbsMinimalBoxState extends State<AbsMinimalBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.layer == 1
            ? Provider.of<ThemeProvider>(context).mainColor
            : Provider.of<ThemeProvider>(context).secondaryColor,
        borderRadius: widget.roundedBorder
            ? BorderRadius.circular(22)
            : BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget.child,
      ),
    );
  }
}
