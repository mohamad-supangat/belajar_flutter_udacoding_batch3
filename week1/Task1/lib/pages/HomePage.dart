import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Task1/pages/RegisterPage.dart';

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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Selamat datang di Dapor Merah dimana kamu dapat menikmati masakan mewah ala resto bingtang 5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(),
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
                            side: BorderSide(color: Colors.red)),
                        child: Text('Pendaftaran'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        onPressed: () => {},
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.red)),
                        child: Text('Edit Profile'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Aplikasi ini dibuat untuk memenuhi Task 1 Week 1 Udacoding flutterBatch 3',
                    textAlign: TextAlign.center,
                    // style: TextStyle(fontSize: 20),
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
