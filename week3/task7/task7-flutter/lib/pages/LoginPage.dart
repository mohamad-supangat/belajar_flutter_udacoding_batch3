import 'package:flutter/material.dart';
import 'package:task7/helpers/toast.dart';
import 'package:task7/pages/RegisterPage.dart';
import 'package:task7/helpers/api.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecurePassword = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  // proses pengecekan login
  void _prosesLogin() {
    callApi().post(
      '/user/login',
      data: {
        'username': _usernameController.text,
        'password': _passwordController.text,
      },
    );
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
                  Image.asset('assets/images/image843.png'),
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
                          height: 20,
                        ),
                        RawMaterialButton(
                          fillColor: Colors.red,
                          elevation: 0,
                          textStyle: TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
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
                          ),
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
                                  Navigator.pushNamed(context, '/registerPage'),
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
                    'Aplikasi Submission week3 task7 udacoding | Mohamad Supangat',
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
