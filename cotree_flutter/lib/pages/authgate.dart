import 'package:flutter/material.dart';
import 'package:cotree_flutter/pages/login_page.dart';
import 'package:cotree_flutter/pages/home_page.dart';
import 'package:cotree_flutter/main.dart'; // for sessionManager

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    sessionManager.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    sessionManager.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    setState(() {}); // rebuild when login/logout happens
  }

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
