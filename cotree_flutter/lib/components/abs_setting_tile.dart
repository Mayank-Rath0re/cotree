import 'package:cotree_flutter/components/abs_text.dart';
import 'package:flutter/material.dart';

class AbsSettingTile extends StatefulWidget {
  final String name;
  const AbsSettingTile({super.key, required this.name});

  @override
  State<AbsSettingTile> createState() => _AbsSettingTileState();
}

class _AbsSettingTileState extends State<AbsSettingTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              AbsText(displayString: widget.name, fontSize: 17),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
        ));
  }
}
