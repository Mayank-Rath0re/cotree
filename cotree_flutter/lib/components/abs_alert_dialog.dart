import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsAlertDialog extends StatefulWidget {
  final String alert;
  const AbsAlertDialog({super.key, required this.alert});

  @override
  State<AbsAlertDialog> createState() => _AbsAlertDialogState();
}

class _AbsAlertDialogState extends State<AbsAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Container(
          constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    FluentIcons.dismiss_16_filled,
                    color: Provider.of<ThemeProvider>(context).contrastColor,
                  )),
            ),
            const SizedBox(height: 20),
            AbsText(
              displayString: widget.alert,
              fontSize: 16,
              align: true,
            )
          ])),
    );
  }
}
