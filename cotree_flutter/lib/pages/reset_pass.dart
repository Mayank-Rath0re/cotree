import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/components/abs_warning_tile.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirm = TextEditingController();
  int step = 0;
  bool otpSent = false;
  bool otpVerified = false;
  bool warning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_rounded),
      )),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AbsText(
                    displayString: "Reset Password",
                    fontSize: 24,
                    headColor: true,
                    bold: true),
                const SizedBox(height: 8),
                const AbsText(
                    displayString:
                        "Receive an OTP on your email for password reset",
                    fontSize: 14),
                const SizedBox(
                  height: 20,
                ),
                if (warning) ...[
                  AbsWarningTile(
                      warning: "e-mail field cannot be empty",
                      closeState: () {
                        setState(() {
                          warning = false;
                        });
                      })
                ],
                const AbsText(displayString: "e-mail", fontSize: 18),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(height: 8),
                AbsTextfield(
                    hintText: "sample@xyz.com", controller: emailController),
                const SizedBox(height: 10),
                if (!otpSent) ...[
                  Row(
                    children: [
                      const Spacer(),
                      AbsButtonPrimary(
                          onPressed: () {
                            if (emailController.text != "") {
                              setState(() {
                                otpSent = true;
                                warning = false;
                              });
                            } else {
                              setState(() {
                                warning = true;
                              });
                            }
                          },
                          text: "Receive OTP"),
                    ],
                  )
                ] else ...[
                  const SizedBox(height: 20),
                  const AbsText(
                      displayString: "Enter OTP below",
                      fontSize: 15,
                      headColor: true),
                  const SizedBox(height: 15),
                  OtpTextField(
                    enabled: otpVerified ? false : true,
                    numberOfFields: 6,
                    focusedBorderColor:
                        Provider.of<ThemeProvider>(context).headColor,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    onSubmit: (val) {
                      setState(() {
                        otpVerified = true;
                      });
                    },
                  ),
                  if (otpVerified) ...[
                    const SizedBox(height: 20),
                    const AbsText(
                        displayString: "New Credentials",
                        fontSize: 18,
                        headColor: true),
                    const SizedBox(height: 10),
                    AbsTextfield(
                        hintText: "new password", controller: newPassword),
                    const SizedBox(height: 10),
                    AbsTextfield(
                        hintText: "confirm password",
                        controller: newPasswordConfirm),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: AbsButtonPrimary(
                                onPressed: () {}, text: "Change Password"))
                      ],
                    )
                  ]
                ]
              ],
            ),
          )),
    );
  }
}
