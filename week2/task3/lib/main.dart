import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:task3/CountingForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              child: CountingForm(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown,
          child: Icon(Icons.account_circle_sharp),
          onPressed: () async {
            const url = 'https://github.com/supangatoy';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Tidak bisa membuka url';
            }
          },
        ),
      ),
    );
  }
}
