import 'package:flutter/material.dart';

import 'package:sayangdompet/ui/DetailTransactions.dart';
import 'package:sayangdompet/ui/ListTransactions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _screens = [
    DetailTransactions(),
    ListTransactions(),
  ];
  int _indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_indexScreen],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
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
            label: 'Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}
