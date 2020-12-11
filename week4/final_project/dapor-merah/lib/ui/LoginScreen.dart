import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../helpers/api.dart';
import '../helpers/toast.dart';
import '../helpers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecurePassword = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cekSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset('assets/images/image843.png'),
              // SizedBox(height: 50),
              Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Hi, ',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Koki Rumah',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.account_circle_sharp),
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String arg) {
                        if (arg == '')
                          return 'Username tidak boleh kosong';
                        else if (arg.length < 3)
                          return 'Username harus lebih dari 5 karakter';
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passwordController,
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
                        filled: true,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_sharp),
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String arg) {
                        if (arg == '')
                          return 'Password tidak boleh kosong';
                        else if (arg.length < 5)
                          return 'Password harus lebih dari 5 karakter';
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RawMaterialButton(
                      fillColor: Colors.red,
                      elevation: 0,
                      textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: _loginButton(),
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        // cek validasi form
                        if (_formKey.currentState.validate()) {
                          // cek user login proses
                          _prosesLogin();
                        } else {
                          showToast(
                            type: 'error',
                            message: _checkValidationText(),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Belum punya akun ?'),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/register'),
                          child: Text(
                            'Daftar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      'Aplikasi submission final projek aplikasi dapor merah, komunitas sharing resep | Mohamad Supangat',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _loginButton() {
    if (_isLoading) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right,
              color: Colors.red,
            ),
          ),
          Text(
            'MASUK SEKARANG',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      );
    }
  }

  // pengecekan form input
  String _checkValidationText() {
    if (_usernameController.text == '')
      return 'Username tidak boleh kosong';
    else if (_usernameController.text.length < 5)
      return 'Username tidak boleh kurang dari 5 karakter';
    else if (_passwordController.text == '')
      return 'Password tidak boleh kosong';
    else if (_passwordController.text.length < 5)
      return 'Password tidak boleh kurang dari 5 karakter';
    else {
      return 'Validasi gagal';
    }
  }

  void _cekSession() async {
    String token = await Auth().token();
    if (token != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    }
  }

  // proses pengecekan login
  void _prosesLogin() async {
    setState(() => _isLoading = true);
    try {
      await callApi().post(
        '/user/login',
        data: {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'remember': true,
        },
      ).then((response) async {
        if (!response.data['status']) {
          showToast(type: 'error', message: response.data['message']);
        } else {
          // masukan token dan tmp user di dalam shared_preferences
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();

          localStorage.setString(
            'token',
            response.data['token'].toString(),
          );

          localStorage.setString(
            'user',
            jsonEncode(response.data['user']).toString(),
          );

          // pindahkan page ke HomePage
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (Route<dynamic> route) => false,
          );
        }
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
