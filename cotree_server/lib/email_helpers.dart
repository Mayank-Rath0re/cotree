// lib/src/email_helpers.dart
import 'package:serverpod/serverpod.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// Composes HTML content for verification email.
String verificationEmailHtml(String code) => '''
  <div style="font-family: system-ui, Segoe UI, Roboto, Helvetica, Arial, sans-serif">
    <h2>Verify your email</h2>
    <p>Use this code to complete your signup:</p>
    <p style="font-size: 24px; font-weight: bold; letter-spacing: 2px;">$code</p>
    <p>This code will expire shortly. If you didn’t request this, ignore this email.</p>
  </div>
''';

/// Plain-text version of verification email.
String verificationEmailText(String code) =>
    'Verify your email.\nYour code: $code\nIf you didn’t request this, ignore this email.';

/// HTML content for password reset email.
String passwordResetHtml(String code) => '''
  <div style="font-family: system-ui, Segoe UI, Roboto, Helvetica, Arial, sans-serif">
    <h2>Reset your password</h2>
    <p>Use this code to reset your password:</p>
    <p style="font-size: 24px; font-weight: bold; letter-spacing: 2px;">$code</p>
    <p>If you didn’t request this, you can ignore this email.</p>
  </div>
''';

/// Plain-text version of password reset email.
String passwordResetText(String code) =>
    'Reset your password.\nYour code: $code\nIf you didn’t request this, ignore this email.';

/// Generic function to send an email using SMTP credentials from Serverpod passwords.
Future<bool> sendEmail({
  required Session session,
  required String toEmail,
  required String subject,
  required String htmlBody,
  required String textBody,
}) async {
  final pw = session.passwords;
  final host = pw['smtpHost'];
  final portStr = pw['smtpPort'] ?? '587';
  final user = pw['smtpUser'];
  final pass = pw['smtpPass'];
  final useSsl = (pw['smtpUseSsl'] ?? 'false').toLowerCase() == 'true';

  if (host == null || user == null || pass == null) {
    session.log('SMTP config missing (smtpHost/smtpUser/smtpPass)',
        level: LogLevel.error);
    return false;
  }

  final port = int.tryParse(portStr) ?? (useSsl ? 465 : 587);

  final server = SmtpServer(
    host,
    port: port,
    username: user,
    password: pass,
    ssl: useSsl,
    ignoreBadCertificate: false,
    allowInsecure: false,
  );

  final message = Message()
    ..from = Address(user, 'Cotree')
    ..recipients.add(toEmail)
    ..subject = subject
    ..text = textBody
    ..html = htmlBody;

  try {
    final sendReport = await send(message, server);
    session.log('Email sent: $sendReport', level: LogLevel.info);
    return true;
  } catch (e, st) {
    session.log('Email send failed: $e', level: LogLevel.error, stackTrace: st);
    return false;
  }
}
