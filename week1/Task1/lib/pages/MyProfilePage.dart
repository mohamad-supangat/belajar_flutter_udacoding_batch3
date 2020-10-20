import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  final profile;
  MyProfilePage({@required this.profile});

  @override
  _MyProfilePageState createState() => _MyProfilePageState(profile);
}

class _MyProfilePageState extends State<MyProfilePage> {
  final profile;
  bool _editable;
  TextEditingController _nameController;
  TextEditingController _usernameController;
  TextEditingController _emailController;

  _MyProfilePageState(this.profile);
  @override
  void initState() {
    super.initState();
    _editable = false;
    _nameController = TextEditingController(text: profile.name);
    _usernameController = TextEditingController(text: profile.username);
    _emailController = TextEditingController(text: profile.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePicture(
              url: profile.profileImage,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: "Nama Lengkap"),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
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
