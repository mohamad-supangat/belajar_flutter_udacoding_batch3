import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import './Project.dart';

class HomePage extends StatelessWidget {
  List projects = [
    Project.fromJson({
      'image': 'assets/images/task4/logo.png',
      'judul': 'Task 4 | Login from',
      'routeName': 'Task4Main'
    })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'di lab flutter M. Supangat',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'aplikasi task 4 dan task 5 mentoring udacoding flutter batch3 week2',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10),
                child: ResponsiveGridRow(
                  children: projects.map((project) {
                    return ResponsiveGridCol(
                      xs: 6,
                      sm: 4,
                      md: 3,
                      lg: 2,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: Image.asset(
                                    'assets/images/task4/logo.png',
                                  ),
                                ),
                                Text(project.judul),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
