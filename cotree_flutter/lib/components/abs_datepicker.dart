import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // Assuming you're using Provider for ThemeProvider

class AbsDatepicker extends StatefulWidget {
  final Function(DateTime) onDatePicked;

  const AbsDatepicker({super.key, required this.onDatePicked});

  @override
  State<AbsDatepicker> createState() => _AbsDatepickerState();
}

class _AbsDatepickerState extends State<AbsDatepicker> {
  DateTime? selectedDate;
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Provider.of<ThemeProvider>(context).headColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      widget.onDatePicked(picked);
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          _pickDate(context);
        },
        child: AbsMinimalBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AbsText(
                displayString: selectedDate == null
                    ? "Select Date"
                    : DateFormat('dd-MM-yyyy HH:mm').format(selectedDate!),
                fontSize: 18),
            const Icon(Icons.calendar_today_outlined)
          ],
        )));
  }
}
