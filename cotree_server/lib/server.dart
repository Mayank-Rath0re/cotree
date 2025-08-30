// lib/server.dart
import 'package:cotree_server/email_helpers.dart';
import 'package:serverpod/serverpod.dart';
import 'src/web/routes/root.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

void run(List<String> args) async {
  var pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, emailID, validationCode) async {
      print(validationCode);
      return true;

      /*return sendEmail(
        session: session,
        toEmail: emailID,
        subject: 'Verify your email',
        htmlBody: verificationEmailHtml(validationCode),
        textBody: verificationEmailText(validationCode),
      );
      */
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      return sendEmail(
        session: session,
        toEmail: userInfo.email!,
        subject: 'Reset your password',
        htmlBody: passwordResetHtml(validationCode),
        textBody: passwordResetText(validationCode),
      );
    },
    onUserCreated: (session, userInfo) async {
      // Post-creation hook (optional)
      return;
    },
  ));

  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  pod.webServer.addRoute(auth.RouteGoogleSignIn(), '/googlesignin');
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  await pod.start();
}
