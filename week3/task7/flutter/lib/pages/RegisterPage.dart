import 'package:flutter/material.dart';
import 'package:task7/pages/LoginPage.dart';
import 'package:task7/helpers/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obsecurePassword = true;
  bool _obsecurePasswordConfirmation = true;
  bool _agree = false;

  // form && text editing controller
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmationPasswordController =
      TextEditingController();

  _validatior({arg, name}) {
    if (arg == '')
      return '$name tidak boleh kosong';
    else if (arg.length < 3)
      return '$name harus lebih dari 5 karakter';
    else
      return null;
  }

  void _prosesRegister() {
    if (!_agree) {
      $toast(
        type: 'error',
        message:
            'Kamu belum menyetujui Syarat dan Ketentuan dan Kebijakan Privasi yang berlaku.',
      );
    }
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
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  children: [
                    Text(
                      'Halaman Pendaftaran',
                      style: TextStyle(
                        fontFamily: 'ConcertOne',
                        color: Colors.red,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (String arg) =>
                          _validatior(arg: arg, name: 'Nama Lengkap'),
                      decoration: InputDecoration(labelText: 'Nama Lengkap *'),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      validator: (String arg) =>
                          _validatior(arg: arg, name: 'Username'),
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (String arg) =>
                          _validatior(arg: arg, name: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'E-mail'),
                    ),
                    TextFormField(
                      obscureText: this._obsecurePassword,
                      controller: _passwordController,
                      validator: (String arg) =>
                          _validatior(arg: arg, name: 'Password'),
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                      ),
                    ),
                    TextFormField(
                      obscureText: this._obsecurePasswordConfirmation,
                      controller: _confirmationPasswordController,
                      validator: (String arg) {
                        if (arg != _passwordController.text) {
                          return 'Password dan password konfirmasi tidak sama';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: !this._obsecurePasswordConfirmation
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => this._obsecurePasswordConfirmation =
                                !this._obsecurePasswordConfirmation);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          onChanged: (newValue) {
                            setState(() => _agree = newValue);
                          },
                          value: _agree,
                        ),
                        Flexible(
                          child: Text(
                            'Saya menyetujui Syarat dan Ketentuan dan Kebijakan Privasi yang berlaku.',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _prosesRegister();
                          } else {
                            $toast(
                              type: 'error',
                              message:
                                  'Pastikan yang anda inputkan sudah benar',
                            );
                          }
                        },
                        padding: EdgeInsets.all(15),
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('DAFTAR SEKARANG'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sudah punya akun ?'),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage(),
                            ),
                          ),
                          child: Text(
                            'Masuk',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
