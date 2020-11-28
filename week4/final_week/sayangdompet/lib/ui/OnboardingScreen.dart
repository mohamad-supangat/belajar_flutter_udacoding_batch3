import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../db/Intro.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        pages: _buildOnboarding(),
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeColor: Colors.red,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  void _onIntroEnd(context) {
    // Navigator.of(context).push(
    //     // MaterialPageRoute(builder: (_) => HomePage()),
    //     );
  }

  List _buildOnboarding() {
    return dbIntroOnboarding.map((intro) {
      return PageViewModel(
        title: intro.title,
        image: Align(
          child: Image.asset(intro.image, width: 200),
          alignment: Alignment.bottomCenter,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w700,
            // color: Colors.red,
          ),
          bodyTextStyle: TextStyle(fontSize: 12),
          descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          pageColor: Colors.white,
          imagePadding: EdgeInsets.zero,
        ),
        bodyWidget: Text(
          intro.descrtiption,
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
  }
}
