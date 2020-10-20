import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Task1/pages/RegisterPage.dart';
import 'package:Task1/pages/MyProfilePage.dart';
import 'package:Task1/models/Profile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
        child: Icon(Icons.account_circle_sharp),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/image843.png'),
            Container(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                    ),
                  ),
                  Text(
                    'Dapor Merah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
                      fontFamily: 'ConcertOne',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Text('Pendaftaran'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfilePage(
                                profile: Profile.fromJson({
                                  "name": "Mohamad Supangat",
                                  "username": "supangat",
                                  "email": "supangatoy@gmail.com",
                                  "profile_image":
                                      "https://github.com/supangatoy.png",
                                  "password": "12345"
                                }),
                              ),
                            ),
                          );
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.red)),
                        child: Text('My Profile'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Aplikasi ini dibuat untuk memenuhi Task 1 Week 1 Udacoding Flutter Batch 3',
                    textAlign: TextAlign.center,
                    // style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://github.com/supangatoy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak bisa membuka url';
    }
  }
}
