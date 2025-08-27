import 'package:cotree_flutter/components/abs_alert_dialog.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_passfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/reset_pass.dart';
import 'package:cotree_flutter/pages/signup_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);

  int _selectedIndex = 0;
  late UserInfo? logCheck;
  List<IconData> modeIcon = [Icons.sunny, Icons.nights_stay];

  @override
  void initState() {
    sessionManager.addListener(_onAuthChanged);
    super.initState();
  }

  @override
  void dispose() {
    sessionManager.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 65,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _selectedIndex = (_selectedIndex + 1) % 2;
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                }),
                child: Icon(
                  modeIcon[_selectedIndex],
                  size: 35,
                  color: Provider.of<ThemeProvider>(context).contrastColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: AbsButtonSecondary(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              ),
              text: "Sign Up",
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 28, right: 28, bottom: 28),
              child: Image.asset(
                "assets/cotree_logo.png",
                fit: BoxFit.contain,
                height: 100,
                color: Provider.of<ThemeProvider>(context).contrastColor,
              ),
            ),
            AbsTextfield(hintText: "e-mail", controller: emailController),
            const SizedBox(height: 15),
            AbsPassfield(hintText: "password", controller: passwordController),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetPass()),
                ),
                child: const AbsText(
                  displayString: "Forgot Password?",
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login Button Functionality
            AbsButtonPrimary(
              onPressed: () async {
                // Both fields should be non-empty
                if (emailController.text != "" &&
                    passwordController.text != "") {
                  // Attempt sign in with the given credentials
                  logCheck = await authController.signIn(
                    emailController.text,
                    passwordController.text,
                  );
                  // If attempts returns a value, then account exists
                  // redirect the user to home page
                  if (logCheck != null) {
                  }
                  // If account doesn't exist, return wrong credentials popup
                  else {
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => const AbsAlertDialog(
                        alert: "Incorrect password or e-mail",
                      ),
                    );
                  }
                }
                // If at least one field is empty, return popup
                // requiring both credentials
                else {
                  showDialog(
                    context: context,
                    builder: (context) => const AbsAlertDialog(
                      alert: "Both e-mail and password must be provided!",
                    ),
                  );
                }
              },
              fontSize: 20,
              text: "Login",
            ),
            const SizedBox(height: 15),
            const AbsText(displayString: "OR", fontSize: 15, bold: true),
            const SizedBox(height: 25),
            Column(
              children: [
                SignInWithGoogleButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Provider.of<ThemeProvider>(context).mainColor),
                      foregroundColor: WidgetStatePropertyAll(
                          Provider.of<ThemeProvider>(context).contrastColor)),
                  caller: client.modules.auth,
                  onFailure: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const AbsText(
                          displayString:
                              "Error: Google Login Invalid or Unavailable",
                          fontSize: 16,
                          bold: true,
                        ),
                      ),
                    );
                  },
                  clientId:
                      "46034047722-ng36snguce49qig7u5j3jog4l22hbk56.apps.googleusercontent.com", // (Android/iOS)
                  serverClientId:
                      "46034047722-81omi8rmahdt66ph8jd8q4lenkvaeaj6.apps.googleusercontent.com", // (Web/required)
                  redirectUri: Uri.parse('http://$ipAddress:8082/googlesignin'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
