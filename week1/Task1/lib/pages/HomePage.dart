import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      onPressed: () => {},
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
    );
  }
}
