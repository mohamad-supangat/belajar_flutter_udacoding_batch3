import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import '../helpers/auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/icon.png',
                width: 200,
              ),
            ),
            SizedBox(height: 80),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  startSplashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introFinish = prefs.getBool('IntroFinish');
    String token = await Auth().token();

    Duration duration = Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(
        context,
        introFinish == null || introFinish == false
            ? '/onboarding'
            : (token == null ? '/login' : '/home'),
      );
    });
  }
}
