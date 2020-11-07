import 'package:flutter/material.dart';
import 'NewsPage.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Doktor Merah'),
        actions: [],
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Auth().logout().then((status) {
                Navigator.pushReplacementNamed(context, '/login');
              });
            },
            child: Text('asdasd'),
          )
        ],
      ),
    );
  }
}
