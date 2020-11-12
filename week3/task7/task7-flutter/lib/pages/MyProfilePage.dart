import 'package:flutter/material.dart';
import '../models/User.dart';
import '../helpers/auth.dart';
import '../config.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _obsecurePassword = true;
  User _user;
  Map<String, TextEditingController> _textController = {};

  @override
  void initState() {
    _getUserState();
    super.initState();
  }

  // dapatkan user dari class auth helper
  void _getUserState() async {
    User user = await Auth().user();
    setState(() => {_user = user});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePicture(
              url: 'asdasdasd',
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _textController['name'],
                            decoration: InputDecoration(
                              labelText: "Nama Lengkap",
                            ),
                          ),
                          TextFormField(
                            controller: _textController['username'],
                            decoration: InputDecoration(
                              labelText: "Username",
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _textController['email'],
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                          TextFormField(
                            controller: _textController['password'],
                            obscureText: this._obsecurePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: !this._obsecurePassword
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() => this._obsecurePassword =
                                      !this._obsecurePassword);
                                },
                              ),
                              labelText: 'Password',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatefulWidget {
  final url;
  ProfilePicture({this.url});
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

// rouded foto profile
class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[400],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: widget.url == null
                          ? AssetImage('assets/images/default-user.png')
                          : NetworkImage(config()['baseUrl'] + widget.url),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 15.0,
                      ),
                      padding: EdgeInsets.all(5.0),
                      shape: CircleBorder(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
