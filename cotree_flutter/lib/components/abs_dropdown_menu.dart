import 'package:flutter/material.dart';

class AbsDropdownMenu extends StatelessWidget {
  final List<String> items;
  final TextEditingController controller;
  const AbsDropdownMenu(
      {super.key, required this.items, required this.controller});

  List<DropdownMenuEntry> menuEntry(List<String> items) {
    List<DropdownMenuEntry> menu = [];
    for (int i = 0; i < items.length; i++) {
      menu.add(DropdownMenuEntry(value: items[i], label: items[i]));
    }
    return menu;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      textStyle: const TextStyle(fontFamily: "Poppins"),
      dropdownMenuEntries: menuEntry(items),
      controller: controller,
    );
  }
}
