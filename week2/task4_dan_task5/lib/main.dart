import 'package:flutter/material.dart';
import 'package:task4_dan_task5/HomePage.dart';
import 'package:task4_dan_task5/Task4/Task4.dart';
import 'package:task4_dan_task5/Task5/Task5.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 4 dan Task 5 Udacoding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: HomePage(),
      routes: {
        '/task4': (BuildContext context) => Task4(),
        '/task5': (BuildContext contex) => Task5(),
      },
    );
  }
}
