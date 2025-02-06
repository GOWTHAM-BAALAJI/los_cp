import 'package:flutter/material.dart';
import 'auth/login_page.dart';
import 'my_application/applicationScreen.dart';
import 'transactions/main_page.dart';
import 'profile/main_page.dart';
import 'package:flutter/services.dart';
import './home_page.dart';
import './theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
    );
  }
}
