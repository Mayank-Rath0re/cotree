import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:flutter/material.dart';

class AbsSearchHist extends StatelessWidget {
  final String hist;
  const AbsSearchHist({super.key, required this.hist});

  @override
  Widget build(BuildContext context) {
    return AbsMinimalBox(
        roundedBorder: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(Icons.auto_graph_outlined),
              AbsText(displayString: hist, fontSize: 14),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_outward))
            ],
          ),
        ));
  }
}
