import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../db/Geometrys.dart';
import './KalkulatorPage.dart';

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
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontFamily: 'ConcertOne',
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(),
                ResponsiveGridRow(
                  children: geometrysDb.map((geometry) {
                    return ResponsiveGridCol(
                      xs: 6,
                      sm: 6,
                      md: 4,
                      lg: 3,
                      xl: 4,
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KalkulatorPage(geometry),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.asset(geometry.logo),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(geometry.nama),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Divider(),
                Text(
                  'Aplikasi Task5 Mohamad. Supangat | Kalkulator perhitungan matematika',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
