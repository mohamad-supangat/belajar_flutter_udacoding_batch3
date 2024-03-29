import 'package:flutter/material.dart';
import '../helpers/api.dart';
import '../helpers/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obsecurePassword = true;
  bool _obsecurePasswordConfirmation = true;
  bool _agree = false;
  bool _isLoading = false;

  // form && text editing coFailed to open inode FILE_Bitmap: No such file or directoryntroller
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmationPasswordController =
      TextEditingController();

  // fungsi untuk membuat pesan validasi
  _validatior({arg, name}) {
    if (arg == '')
      return '$name tidak boleh kosong';
    else if (arg.length < 3)
      return '$name harus lebih dari 5 karakter';
    else
      return null;
  }

  void _prosesRegister() async {
    if (!_agree) {
      showToast(
        type: 'error',
        message:
            'Kamu belum menyetujui Syarat dan Ketentuan dan Kebijakan Privasi yang berlaku.',
      );
    } else {
      setState(() => _isLoading = true);
      try {
        await callApi().post('/user/register', data: {
          'username': _usernameController.text,
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'confirmation_password': _confirmationPasswordController.text,
        }).then((response) {
          showToast(
            type: response.data['status'] ? 'success' : 'error',
            message: response.data['message'],
          );
        });
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                SizedBox(height: 50),
                Text(
                  'Pendaftaran',
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
                      'Selamat Bergabung',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (String arg) =>
                      _validatior(arg: arg, name: 'Nama Lengkap'),
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap *',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _usernameController,
                  validator: (String arg) =>
                      _validatior(arg: arg, name: 'Username'),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  validator: (String arg) =>
                      _validatior(arg: arg, name: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
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
                        color:
                            !this._obsecurePassword ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() =>
                            this._obsecurePassword = !this._obsecurePassword);
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
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
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
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
                        showToast(
                          type: 'error',
                          message: 'Pastikan yang anda inputkan sudah benar',
                        );
                      }
                    },
                    padding: EdgeInsets.all(15),
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: (() {
                      if (!_isLoading) {
                        return Text('DAFTAR SEKARANG');
                      } else {
                        return SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
                    }()),
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
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/login'),
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
      ),
    );
  }
}
