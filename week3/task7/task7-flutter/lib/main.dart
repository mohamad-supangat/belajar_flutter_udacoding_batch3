import 'package:flutter/material.dart';
import 'package:task7/pages/LoginPage.dart';
import 'package:task7/pages/RegisterPage.dart';
import 'package:task7/pages/DashboardPage.dart';
import 'package:task7/helpers/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = new Auth();
  final String _token = await _auth.token();
  MyApp myApp = MyApp(
    initialRoute: (_token != null && _token != '') ? '/dashboard' : '/login',
  );
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dokter Merah',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
