import 'package:cotree_flutter/components/abs_text.dart';
import 'package:flutter/material.dart';

class AbsWarningTile extends StatelessWidget {
  final String warning;
  final Function()? closeState;
  const AbsWarningTile(
      {super.key, required this.warning, required this.closeState});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(minHeight: 60),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.warning_amber),
            const SizedBox(width: 7),
            AbsText(displayString: warning, fontSize: 15),
            const Spacer(),
            TextButton(onPressed: closeState, child: const Icon(Icons.close))
          ],
        ),
      ),
    );
  }
}
