import 'package:flutter/material.dart';

import '../ui/SplashScreen.dart';
import '../ui/OnboardingScreen.dart';
import '../ui/LoginScreen.dart';
import '../ui/RegisterScreen.dart';
import '../ui/HomeScreen.dart';

var routes = <String, WidgetBuilder>{
  '/splashScreen': (context) => SplashScreen(),
  '/onboarding': (context) => OnboardingScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => HomeScreen(),
};
