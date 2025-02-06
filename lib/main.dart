import 'package:flutter/material.dart';
import 'auth/login_page.dart';
import 'my_application/applicationScreen.dart';
import 'transactions/main_page.dart';
import 'profile/main_page.dart';
import 'package:flutter/services.dart';
import './theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  const FlutterSecureStorage storage = FlutterSecureStorage();
  String? isLogoutClicked = await storage.read(key: 'isLogoutClicked');

  runApp(MyApp(isLoggedOut: isLogoutClicked == 'true'));
}

class MyApp extends StatelessWidget {
  final bool isLoggedOut;

  const MyApp({Key? key, required this.isLoggedOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOS',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/portfolio': (context) => applicationScreen(),
        '/transactions': (context) => TransactionsPage(),
        '/profile': (context) => ProfilePage(),
        // '/home': (context) => HomePage(),
      },
      home: isLoggedOut ? const LoginPage() : HomePage(),
    );
  }
}
