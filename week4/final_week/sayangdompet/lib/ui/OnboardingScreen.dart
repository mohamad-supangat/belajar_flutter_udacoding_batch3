import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../db/Intro.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper.children(
        index: 0,
        autoplay: false,
        loop: false,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(bottom: 100),
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.red,
            size: 5,
            activeSize: 8,
          ),
        ),
        control: SwiperControl(
          iconNext: null,
          iconPrevious: null,
        ),
        children: _buildOnboarding(),
      ),
    );
  }

  List _buildOnboarding() {
    return dbIntroOnboarding.map((intro) {
      return Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            Container(
              child: Image.asset(
                intro.image,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height / 3.5,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                intro.title,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  intro.descrtiption,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    // wordSpacing: 3,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
