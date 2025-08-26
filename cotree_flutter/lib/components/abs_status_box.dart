import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsStatusBox extends StatelessWidget {
  final String text;
  const AbsStatusBox({super.key, required this.text});

  Color getColor() {
    if (text == "Completed") {
      return Colors.blue;
    } else if (text == "In Progress" || text == "Ongoing") {
      return Colors.green;
    } else if (text == "To Do" || text == "Halted") {
      return Colors.amber.shade800;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).secondaryColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: getColor())),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: getColor()),
            ),
          ),
        ));
  }
}
