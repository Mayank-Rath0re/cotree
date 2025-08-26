import 'package:flutter/material.dart';

class AbsSelectTab extends StatefulWidget {
  final List<Widget> icons;
  final List<String> texts;
  final int selectedIndex;
  const AbsSelectTab({
    super.key,
    required this.icons,
    required this.texts,
    required this.selectedIndex,
  });

  @override
  State<AbsSelectTab> createState() => _AbsSelectTabState();
}

class _AbsSelectTabState extends State<AbsSelectTab> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < widget.texts.length; i++) ...[
          Container(
            child: Column(
              children: [widget.icons[i], const SizedBox(height: 10)],
            ),
          )
        ]
      ],
    );
  }
}
