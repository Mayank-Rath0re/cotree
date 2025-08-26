import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:flutter/material.dart';

class AbsRoundedIconOptions extends StatefulWidget {
  final List<Icon> icons;
  final List<Function()?> onTaps;
  const AbsRoundedIconOptions(
      {super.key, required this.icons, required this.onTaps});

  @override
  State<AbsRoundedIconOptions> createState() => _AbsRoundedIconOptionsState();
}

class _AbsRoundedIconOptionsState extends State<AbsRoundedIconOptions> {
  @override
  Widget build(BuildContext context) {
    return AbsMinimalBox(
        roundedBorder: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.icons.length; i++) ...[
              IconButton(onPressed: widget.onTaps[i], icon: widget.icons[i]),
              const VerticalDivider(
                width: 1,
              ),
            ]
          ],
        ));
  }
}
