import 'package:flutter/material.dart';

import 'package:sayangdompet/ui/DetailTransactions.dart';
import 'package:sayangdompet/ui/ListTransactions.dart';
import 'package:sayangdompet/ui/MyProfile.dart';
import 'package:sayangdompet/ui/ReciptAction.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _screens = [
    DetailTransactions(),
    ListTransactions(),
    MyProfile(),
  ];

  int _indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_indexScreen],
      floatingActionButton: () {
        if (_indexScreen == 2) {
          return null;
        } else {
          return FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReciptAction()),
              );
            },
            child: Icon(Icons.add),
          );
        }
      }(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _indexScreen = index;
          });
        },
        currentIndex: _indexScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Statistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
