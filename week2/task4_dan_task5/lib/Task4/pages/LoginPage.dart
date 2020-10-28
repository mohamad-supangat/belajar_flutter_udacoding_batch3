import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './../models/Profile.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecurePassword = true;
  final _formKey = GlobalKey<FormState>();
  FToast fToast;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  // fungsi untuk menampilkan toast
  void _showToast({msg, type}) {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.red,
        ),
        child: Text(
          msg,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // proses pengecekan login
  bool _prosesLogin({username, password}) {
    if (username == 'admin' && password == 'admin')
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Image.asset('assets/images/task4/image843.png'),
                ],
              ),
            ),
            Text(
              'Halaman Login',
              style: TextStyle(
                fontFamily: 'ConcertOne',
                color: Colors.red,
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
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
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
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
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
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
                          height: 10,
                        ),
                        RawMaterialButton(
                          fillColor: Colors.red,
                          elevation: 0,
                          textStyle: TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Masuk Sekarang',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20, left: 20),
                          onPressed: () {
                            // cek validasi form
                            if (_formKey.currentState.validate()) {
                              // cek user login proses
                              if (!_prosesLogin(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              )) {
                                _showToast(
                                  type: 'error',
                                  msg:
                                      'Username dan password yang anda masukan salah',
                                );
                              } else {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/myProfile',
                                  arguments: Profile.fromJson({
                                    "name": "Mohamad Supangat",
                                    "username": "admin",
                                    "email": "supangatoy@gmail.com",
                                    "profile_image":
                                        "https://github.com/supangatoy.png",
                                    "password": "admin"
                                  }),
                                );
                              }
                            } else {
                              _showToast(
                                type: 'error',
                                msg: _checkValidationText(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
                    'Aplikasi Submission week2 task4 udacoding | Login Sederhana | Mohamad Supangat',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
