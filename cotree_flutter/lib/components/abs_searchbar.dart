import 'package:flutter/material.dart';

class AbsSearchbar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  const AbsSearchbar(
      {super.key,
      required this.controller,
      required this.onChanged,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        controller: controller,
        onChanged: (val) => {onChanged!(val)},
        onSubmitted: (val) => {onSubmitted!(val)},
        textInputAction:
            TextInputAction.search, // forces search icon in keyboard
        backgroundColor:
            WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
        textStyle: WidgetStatePropertyAll(
            TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
        hintText: "Search",
        elevation: const WidgetStatePropertyAll(0),
        leading: const Icon(Icons.search),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary, // You can change this
              width: 1.0, // Border width here
            ),
            borderRadius: BorderRadius.circular(35))));
  }
}
