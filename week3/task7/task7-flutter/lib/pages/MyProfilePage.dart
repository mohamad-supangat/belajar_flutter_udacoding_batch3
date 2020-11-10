import 'package:flutter/material.dart';
import '../models/User.dart';
import '../helpers/auth.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _obsecurePassword = true;
  User _user;
  @override
  Widget build(BuildContext context) {
    // final TextEditingController _nameController =
    // TextEditingController(text: profile.name);
    // final TextEditingController _usernameController =
    // TextEditingController(text: profile.username);
    // final TextEditingController _emailController =
    // TextEditingController(text: profile.email);
    // final TextEditingController _passwordController =
    // TextEditingController(text: profile.password);

    return Column(
      children: [
        // ProfilePicture(
        // url: profile.profileImage,
        // ),
        // Container(
        // padding: EdgeInsets.symmetric(
        // vertical: 10,
        // horizontal: 30,
        // ),
        // child: Column(
        // children: [
        // Card(
        // shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(20),
        // ),
        // child: Padding(
        // padding: EdgeInsets.all(20),
        // child: Column(
        // children: [
        // TextFormField(
        // controller: _nameController,
        // decoration: InputDecoration(
        // labelText: "Nama Lengkap",
        // ),
        // ),
        // TextFormField(
        // controller: _usernameController,
        // decoration: InputDecoration(
        // labelText: "Username",
        // ),
        // ),
        // TextFormField(
        // keyboardType: TextInputType.emailAddress,
        // controller: _emailController,
        // decoration: InputDecoration(
        // labelText: "Email",
        // ),
        // ),
        // TextFormField(
        // controller: _passwordController,
        // obscureText: this._obsecurePassword,
        // decoration: InputDecoration(
        // suffixIcon: IconButton(
        // icon: Icon(
        // Icons.remove_red_eye,
        // color: !this._obsecurePassword
        // ? Colors.red
        // : Colors.grey,
        // ),
        // onPressed: () {
        // setState(() => this._obsecurePassword =
        // !this._obsecurePassword);
        // },
        // ),
        // labelText: 'Password',
        // ),
        // ),
        // ],
        // ),
        // ),
        // ),
        // ],
        // ),
        // )
      ],
    );
  }
}

class ProfilePicture extends StatefulWidget {
  final url;
  ProfilePicture({this.url});
  @override
  _ProfilePictureState createState() => _ProfilePictureState(url);
}

class _ProfilePictureState extends State<ProfilePicture> {
  final url;
  _ProfilePictureState(this.url);
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
                      image: NetworkImage(url),
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
