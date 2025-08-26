import 'package:flutter/material.dart';
import 'package:cotree_flutter/pages/login_page.dart';
import 'package:cotree_flutter/pages/home_page.dart';
import 'package:cotree_flutter/main.dart'; // for sessionManager

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: sessionManager,
      builder: (context, _) {
        if (sessionManager.isSignedIn) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
