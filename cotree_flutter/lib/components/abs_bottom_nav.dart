import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';

class AbsBottomNav extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onTabChange;

  const AbsBottomNav({
    super.key,
    required this.onTabChange,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.mainColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
          child: GNav(
        selectedIndex: selectedIndex,
        onTabChange: (index) => onTabChange?.call(index),
        backgroundColor: theme.mainColor, // whole bar background
        color: theme.contrastColor, // inactive icon/text
        activeColor: theme.contrastColor, // active icon/text
        tabBackgroundColor: theme.headColor, // active tab background
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        gap: 8,
        iconSize: 24,
        duration: const Duration(milliseconds: 400),
        tabs: [
          GButton(
              icon: selectedIndex == 0
                  ? FluentIcons.home_20_filled
                  : FluentIcons.home_20_regular,
              text: 'Home'),
          GButton(
              icon: selectedIndex == 1
                  ? FluentIcons.people_20_filled
                  : FluentIcons.people_20_regular,
              text: 'Users'),
          GButton(
              icon: selectedIndex == 2
                  ? FluentIcons.briefcase_20_filled
                  : FluentIcons.briefcase_20_regular,
              text: 'Work'),
          GButton(
              icon: selectedIndex == 3
                  ? FluentIcons.chat_multiple_20_filled
                  : FluentIcons.chat_multiple_20_regular,
              text: 'Chat'),
        ],
      )),
    );
  }
}
