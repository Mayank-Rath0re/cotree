import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsDocumentBox extends StatelessWidget {
  final String fileName;
  final Member memberView;
  final DateTime time;
  const AbsDocumentBox(
      {super.key,
      required this.fileName,
      required this.memberView,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return AbsMinimalBox(
        child: Row(
      children: [
        Expanded(
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.file_download_outlined, size: 35))),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsText(displayString: fileName, fontSize: 16, bold: true),
              const SizedBox(height: 8),
              Row(
                children: [
                  const AbsText(displayString: "Uploaded By: ", fontSize: 14),
                  AbsText(
                      displayString: memberView.name, fontSize: 14, bold: true)
                ],
              ),
              const SizedBox(height: 8),
              AbsText(
                  displayString: DateFormat("dd-MM-yyyy HH:mm").format(time),
                  fontSize: 12)
            ],
          ),
        ),
      ],
    ));
  }
}
