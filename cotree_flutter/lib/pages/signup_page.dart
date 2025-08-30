import 'package:cotree_flutter/components/abs_alert_dialog.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_passfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/login_page.dart';
import 'package:cotree_flutter/pages/profile_setup_b.dart';
import 'package:cotree_flutter/pages/profile_setup_i.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers to keep track of data inside the fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController verifyController = TextEditingController();
  final authController = EmailAuthController(client.modules.auth);
  bool creatingAccount = false;
  List<String> accountTypes = ["Individual", "Organization"];
  int _groupValue = 0;

  bool isProvided = true;
  // ignore: prefer_typing_uninitialized_variables
  var check;

  bool checkIfFieldsEmpty() {
    if (nameController.text != "" &&
        emailController.text != "" &&
        passwordController.text != "" &&
        confPassController.text != "") {
      return true;
    } else {
      return false;
    }
  }

// Overload that sets the message for AbsAlertDialog
  Future<void> _showAbsAlert(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      useRootNavigator: true,
      builder: (_) => AbsAlertDialog(alert: message),
    );
  }

  /// Shows OTP dialog and returns the entered code (null if cancelled).
  Future<String?> _promptOtp(BuildContext context) async {
    verifyController.clear();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AbsText(displayString: "Verification Code", fontSize: 16),
              IconButton(
                onPressed: () {
                  Navigator.of(dialogContext, rootNavigator: true).pop(null);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          content: Card(
            child: AbsTextfield(
              hintText: "One-Time Password",
              controller: verifyController,
            ),
          ),
          actions: [
            AbsButtonPrimary(
              text: "Submit",
              fontSize: 14,
              onPressed: () {
                final code = verifyController.text.trim();
                Navigator.of(dialogContext, rootNavigator: true).pop(code);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage())),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Image.asset("assets/cotree_logo.png",
              fit: BoxFit.contain,
              height: 50,
              color: Theme.of(context).colorScheme.inversePrimary),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            // Core structure of the page layout
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: const AbsText(
                  displayString: "Register",
                  fontSize: 24,
                  bold: true,
                  headColor: true,
                ),
              ),
              const SizedBox(height: 10),
              if (!isProvided) ...[
                const AbsText(
                  displayString: "Fields not provided",
                  fontSize: 18,
                )
              ],
              const SizedBox(height: 12),
              const AbsText(
                displayString: "Account Type",
                fontSize: 16,
                bold: true,
              ),
              const SizedBox(height: 5),
              CupertinoSlidingSegmentedControl<int>(
                // The animation for the sliding selection is built-in here.
                children: const <int, Widget>{
                  0: Padding(
                    padding: EdgeInsets.all(8),
                    child: AbsText(
                        displayString: "Individual", fontSize: 16, bold: true),
                  ),
                  1: Padding(
                    padding: EdgeInsets.all(8),
                    child: AbsText(
                        displayString: "Organization",
                        fontSize: 16,
                        bold: true),
                  ),
                },
                groupValue: _groupValue,
                onValueChanged: (int? value) {
                  setState(() {
                    _groupValue = value!;
                  });
                },
                // You can customize colors, but the sliding animation is automatic
                backgroundColor: Provider.of<ThemeProvider>(context).mainColor,
                thumbColor: Provider.of<ThemeProvider>(context).headColor,
                padding:
                    const EdgeInsets.all(12), // Adjust padding around the thumb
              ),
              const SizedBox(
                height: 10,
              ),
              const AbsText(
                displayString: "Name *",
                fontSize: 16,
                bold: true,
              ),
              const SizedBox(height: 5),
              AbsTextfield(
                  hintText: "Ada Lovelace", controller: nameController),
              const SizedBox(height: 10),
              const AbsText(
                displayString: "E-mail *",
                fontSize: 16,
                bold: true,
              ),
              const SizedBox(height: 5),
              AbsTextfield(
                hintText: "abc@sample.com",
                controller: emailController,
              ),
              const SizedBox(height: 10),
              const AbsText(
                  displayString: "Password", fontSize: 16, bold: true),
              const SizedBox(height: 5),
              AbsPassfield(
                hintText: "password",
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              const AbsText(
                displayString: "Confirm Password",
                fontSize: 16,
                bold: true,
              ),
              const SizedBox(height: 5),
              AbsPassfield(
                hintText: "password",
                controller: confPassController,
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.bottomRight,
                child: AbsButtonPrimary(
                  text: "Create Account",
                  fontSize: 16,
                  isLoading: creatingAccount,
                  onPressed: () async {
                    if (creatingAccount) return;

                    // Capture a stable navigator tied to the parent (not the dialog).
                    final rootNav = Navigator.of(context, rootNavigator: true);

                    setState(() => creatingAccount = true);
                    try {
                      // 1) Validate inputs
                      if (!checkIfFieldsEmpty()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("All fields must be provided!"),
                          ),
                        );
                        return;
                      }
                      if (passwordController.text.length < 8) {
                        await _showAbsAlert(context,
                            "Password must be at least 8 characters long");
                        return;
                      }
                      if (passwordController.text != confPassController.text) {
                        await _showAbsAlert(context, "Passwords do not match");
                        return;
                      }
                      // Need to add email already exists check
                      final emailExists = await client.account
                          .checkEmailExists(emailController.text);

                      if (emailExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "An account with this email already exists!"),
                          ),
                        );
                        return;
                      }
                      // 2) Request account creation (send OTP)
                      final requested =
                          await authController.createAccountRequest(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                      if (!mounted) return;

                      if (!requested) {
                        await _showAbsAlert(context, "Error creating account");
                        return;
                      }

                      // 3) Ask user for OTP
                      final otp = await _promptOtp(context);
                      if (!mounted) return;

                      if (otp == null || otp.isEmpty) {
                        await _showAbsAlert(
                            context, "Invalid Verification Code");
                        return;
                      }

                      // 4) Validate account with OTP
                      final check = await authController.validateAccount(
                        emailController.text,
                        otp,
                      );
                      if (!mounted) return;

                      if (check == null) {
                        await _showAbsAlert(
                            context, "Invalid Verification Code");
                        return;
                      }

                      // 5) Sign in
                      await authController.signIn(
                        emailController.text,
                        passwordController.text,
                      );
                      if (!mounted) return;

                      // 6) Create app account entry
                      final createdAccount = await client.account.createAccount(
                        sessionManager.signedInUser!.id,
                        nameController.text,
                        emailController.text,
                        accountTypes[_groupValue],
                        passwordController.text,
                      );
                      if (!mounted) return;

                      if (createdAccount == -1) {
                        await _showAbsAlert(context, "Error Creating Account");
                        return;
                      }

                      // 7) Navigate AFTER dialog is closed, using parent context
                      final isIndividual =
                          accountTypes[_groupValue] == "Individual";

                      // Schedule navigation so it never races the dialog pop.
                      Future.microtask(() {
                        if (!mounted) return;
                        rootNav.pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => isIndividual
                                ? ProfileSetupI(
                                    userView: createdAccount!,
                                  )
                                : ProfileSetupB(
                                    user: createdAccount!,
                                  ),
                          ),
                        );
                      });
                    } finally {
                      if (mounted) {
                        setState(() => creatingAccount = false);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
