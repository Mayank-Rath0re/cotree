import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/models/box_provider.dart';
import 'package:cotree_flutter/pages/authgate.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:provider/provider.dart';

late SessionManager sessionManager;
late Client client;
const ipAddress = '20.196.136.90';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  client = Client(
    'http://$ipAddress:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  await Hive.initFlutter();
  var appCacheBox = await Hive.openBox('app_cache');

  sessionManager = SessionManager(caller: client.modules.auth);
  await sessionManager.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HiveBoxProvider(appCacheBox)),
      ],
      child: MyApp(isSigned: sessionManager.isSignedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isSigned;
  const MyApp({super.key, required this.isSigned});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().themeData,
      home: AuthGate(),
    );
  }
}
