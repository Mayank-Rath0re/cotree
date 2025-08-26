import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:flutter/material.dart';
// Import your custom button if it's in a separate file
// import 'package:your_app/widgets/abs_button_secondary.dart';

class AbsFilterToggle extends StatefulWidget {
  final String title;
  final List<String> options;
  final bool multiSelect;
  final ValueChanged<List<String>> onSelectionChanged;

  const AbsFilterToggle({
    super.key,
    required this.title,
    required this.options,
    required this.onSelectionChanged,
    this.multiSelect = false,
  });

  @override
  State<AbsFilterToggle> createState() => _FilterToggleState();
}

class _FilterToggleState extends State<AbsFilterToggle> {
  bool _isExpanded = false;
  List<String> _selectedOptions = [];

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectOption(String option) {
    setState(() {
      if (widget.multiSelect) {
        if (_selectedOptions.contains(option)) {
          _selectedOptions.remove(option);
        } else {
          _selectedOptions.add(option);
        }
      } else {
        _selectedOptions = [option];
        _isExpanded = false;
      }
    });

    widget.onSelectionChanged(_selectedOptions);
  }

  String get _buttonText {
    if (_selectedOptions.isEmpty) return widget.title;
    if (widget.multiSelect) {
      return "${widget.title} (${_selectedOptions.length})";
    } else {
      return _selectedOptions.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbsButtonSecondary(
          onPressed: _toggle,
          text: _buttonText,
          fontSize: 16,
        ),
        if (_isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options.map((option) {
                final isSelected = _selectedOptions.contains(option);
                return GestureDetector(
                  onTap: () => _selectOption(option),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          widget.multiSelect
                              ? (isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank)
                              : (isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked),
                          size: 20,
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(option),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
