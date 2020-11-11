import 'package:flutter/material.dart';
import 'package:task7/pages/LoginPage.dart';
import 'package:task7/pages/RegisterPage.dart';
import 'package:task7/pages/NewsPage.dart';

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
      },
    );
  }
}
