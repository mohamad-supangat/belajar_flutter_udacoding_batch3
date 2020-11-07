import 'package:flutter/material.dart';
import 'package:task7/pages/LoginPage.dart';
import 'package:task7/pages/RegisterPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dokter Merah',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/registerPage': (context) => RegisterPage(),
      },
      home: LoginPage(),
    );
  }
}
