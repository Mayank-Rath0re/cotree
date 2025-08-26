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
          backgroundColor: theme.mainColor,
          color: theme.contrastColor, // color for inactive icons/text
          activeColor: theme.headColor, // color for active icons/text
          tabBackgroundColor: theme.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          gap: 8, // gap between icon and text
          iconSize: 24,
          duration: const Duration(milliseconds: 400),
          tabs: const [
            GButton(icon: Icons.home_outlined, text: 'Home'),
            GButton(icon: Icons.people_outline, text: 'Users'),
            GButton(icon: Icons.work_outline_rounded, text: 'Work'),
            GButton(icon: Icons.chat_bubble_outline, text: 'Chat'),
          ],
        ),
      ),
    );
  }
}
