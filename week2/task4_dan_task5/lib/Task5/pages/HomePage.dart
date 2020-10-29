import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset('assets/images/task5/bgBangunRuang.png'),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                'Kalkulator Bangun Ruang',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontFamily: 'ConcertOne',
                ),
                textAlign: TextAlign.center,
              ),
              ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    xs: 6,
                    sm: 6,
                    md: 4,
                    lg: 3,
                    xl: 4,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/task5/segitiga.png',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
