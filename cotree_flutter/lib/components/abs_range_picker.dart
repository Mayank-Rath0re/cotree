import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsRangePicker extends StatefulWidget {
  final int initialStart;
  final int initialEnd;
  final Function(int, int)? onChanged;

  const AbsRangePicker({
    required this.initialStart,
    required this.initialEnd,
    required this.onChanged,
    super.key,
  });

  @override
  State<AbsRangePicker> createState() => _AbsRangePickerState();
}

class _AbsRangePickerState extends State<AbsRangePicker> {
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _startController =
        TextEditingController(text: widget.initialStart.toString());
    _endController = TextEditingController(text: widget.initialEnd.toString());
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _onValueChanged() {
    final start = int.tryParse(_startController.text) ?? widget.initialStart;
    final end = int.tryParse(_endController.text) ?? widget.initialEnd;
    if (end > start) {
      widget.onChanged?.call(start, end);
    }
  }

  Widget _rangeField(
      {required String label, required TextEditingController controller}) {
    Color headColor = Provider.of<ThemeProvider>(context).headColor;
    return AbsMinimalBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AbsText(
              displayString: label,
              fontSize: 14,
              bold: true,
              headColor: true,
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: headColor,
              ),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              onChanged: (_) => _onValueChanged(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _rangeField(label: "Start", controller: _startController),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _rangeField(label: "End", controller: _endController),
        ),
      ],
    );
  }
}
