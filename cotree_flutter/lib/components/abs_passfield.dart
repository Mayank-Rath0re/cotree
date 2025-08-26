import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsPassfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const AbsPassfield({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<AbsPassfield> createState() => _AbsTextfieldState();
}

class _AbsTextfieldState extends State<AbsPassfield> {
  bool _visible = false;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
        onTap: () {
          setState(() {
            isActive = true;
          });
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Provider.of<ThemeProvider>(context).mainColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: isActive
                      ? Provider.of<ThemeProvider>(context).headColor
                      : Provider.of<ThemeProvider>(context).contrastColor,
                  width: 2),
            ),
            hintText: widget.hintText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              icon: Icon(
                _visible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            )),
        obscureText: !_visible,
        onChanged: (val) {
          setState(() {
            widget.controller.text = val;
          });
        });
  }
}
