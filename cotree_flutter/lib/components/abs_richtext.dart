import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AbsRichtext extends StatelessWidget {
  final String displayString;
  final bool align;
  final double fontSize;
  final bool headColor;
  final bool bold;
  const AbsRichtext({
    super.key,
    required this.displayString,
    required this.fontSize,
    this.align = false,
    this.headColor = false,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = headColor
        ? Provider.of<ThemeProvider>(context).headColor
        : Provider.of<ThemeProvider>(context).contrastColor;

    Color linkColor =
        Colors.blue.shade800; // You can make this dynamic if needed

    final urlRegex = RegExp(
      r'((https?:\/\/)?([\w-]+\.)+[a-zA-Z]{2,}(\/[\w\d%./?=#-]*)*)',
      caseSensitive: false,
    );

    List<TextSpan> spans = [];
    displayString.splitMapJoin(
      urlRegex,
      onMatch: (match) {
        final url = match.group(0)!;
        spans.add(
          TextSpan(
            text: url,
            style: TextStyle(
              color: linkColor,
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                String rawUrl = url;
                if (!rawUrl.startsWith('http')) {
                  rawUrl = 'https://$rawUrl';
                }

                final uri = Uri.tryParse(rawUrl);

                if (uri != null) {
                  final launched = await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                  if (!launched) {
                    debugPrint("Could not launch $rawUrl");
                  }
                }
              },
          ),
        );
        return '';
      },
      onNonMatch: (nonMatch) {
        spans.add(
          TextSpan(
            text: nonMatch,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
        return '';
      },
    );

    return RichText(
      textAlign: align ? TextAlign.center : TextAlign.start,
      text: TextSpan(children: spans),
      softWrap: true,
      overflow: TextOverflow.clip,
    );
  }
}
