import 'package:flutter/material.dart';

import 'NewsPage.dart';
import 'MyProfilePage.dart';

import '../models/User.dart';
import '../helpers/auth.dart';
import '../config.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;
  List<Widget> _childerns = [
    NewsPage(),
    MyProfilePage(),
  ];
  User _user;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  _getUser() async {
    User user = await Auth().user();
    setState(() => {_user = user});
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Doktor Biru'),
          leading: null,
          actions: [
            PopupMenuButton(
              icon: CircleAvatar(
                backgroundImage: _user.photo == null
                    ? AssetImage('assets/images/default-user.png')
                    : NetworkImage(config()['baseUrl'] + _user.photo),
              ),
              onSelected: (String selected) {
                if (selected == 'logout') {
                  Auth().logout().then((status) {
                    Navigator.pushReplacementNamed(context, '/login');
                  });
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  )
                ];
              },
            )
          ],
        ),
        body: _childerns[_index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Berita',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Profile',
            )
          ],
        ),
      );
    }
  }
}
