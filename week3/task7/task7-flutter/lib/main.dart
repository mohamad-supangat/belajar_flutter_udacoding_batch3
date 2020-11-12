import 'package:flutter/material.dart';

import './pages/LoginPage.dart';
import './pages/RegisterPage.dart';
import './pages/NewsPage.dart';
import './pages/KamusPage.dart';
import './pages/MyProfilePage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doktor News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/news',
      routes: {
        '/news': (context) => NewsPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/myProfile': (context) => MyProfilePage(),
        '/kamus': (context) => KamusPage(),
      },
    );
  }
}
