import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsEmptyBox extends StatelessWidget {
  final String message;

  const AbsEmptyBox({
    super.key,
    this.message = 'No data available',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AbsMinimalBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: Provider.of<ThemeProvider>(context).headColor,
            ),
            const SizedBox(height: 12),
            AbsText(
              displayString: message,
              fontSize: 16,
              align: true,
            )
          ],
        ),
      ),
    );
  }
}
