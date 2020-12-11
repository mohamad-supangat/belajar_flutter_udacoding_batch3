import 'package:flutter/material.dart';

import 'package:sayangdompet/models/User.dart';
import 'package:sayangdompet/helpers/helpers.dart';
import 'package:sayangdompet/config.dart';
import 'package:sayangdompet/repositories/user_repository.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool _obsecurePassword = true;
  User _user;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  // fungsi untuk membuat pesan validasi
  _validatior({arg, name}) {
    if (arg == '')
      return '$name tidak boleh kosong';
    else if (arg.length < 3)
      return '$name harus lebih dari 5 karakter';
    else
      return null;
  }

  void _getUser() async {
    User user = await UserRepository.getUserAuth();
    setState(() => {_user = user});

    // set kedalam form text controller
    _nameController.text = user.name;
    _usernameController.text = user.username;
    _emailController.text = user.email;
  }

  void _saveProses() {
    // cek validasi form
    if (_formKey.currentState.validate()) {
      // call prosess api
      callApi().post('/user/update_profile', data: {
        'username': _usernameController.text,
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }).then((response) {
        showToast(
          type: response.data['status'] ? 'success' : 'error',
          message: response.data['message'],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: _user != null,
        child: FloatingActionButton(
          onPressed: () => _saveProses(),
          child: Icon(Icons.save),
        ),
      ),
      body: (() {
        // tampilkan progress loading ketika varible user belum mendapatkan data
        if (_user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text('Sedang memuat data profile'),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                _generateHeaderAndProfilePicture(
                  url: null,
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
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  validator: (String arg) => _validatior(
                                      arg: arg, name: 'Nama Lengkap'),
                                  decoration: InputDecoration(
                                      labelText: 'Nama Lengkap *'),
                                ),
                                TextFormField(
                                  controller: _usernameController,
                                  validator: (String arg) =>
                                      _validatior(arg: arg, name: 'Username'),
                                  decoration:
                                      InputDecoration(labelText: 'Username'),
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  validator: (String arg) =>
                                      _validatior(arg: arg, name: 'Email'),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      InputDecoration(labelText: 'E-mail'),
                                ),
                                TextFormField(
                                  obscureText: this._obsecurePassword,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    helperText:
                                        'Masukan password baru untuk mengganti / biarkan kosong agar tidak merubah password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: !this._obsecurePassword
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() => this._obsecurePassword =
                                            !this._obsecurePassword);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }()),
    );
  }

  Widget _generateHeaderAndProfilePicture({url}) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/image843.png',
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      bool status = await Auth().logout();
                      if (status) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    // textColor: Colors.white,
                    icon: Icon(Icons.logout),
                    label: Text('Keluar'),
                  ),
                  SizedBox(width: 10)
                ],
              ),
              Center(
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
                              image: url == null
                                  ? AssetImage('assets/images/default-user.png')
                                  : NetworkImage(config()['baseUrl'] + url),
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
            ],
          ),
        )
      ],
    );
  }
}
