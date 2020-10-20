import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obsecurePassword = true;
  bool _obsecurePasswordConfirmation = true;

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
                  SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Halaman Pendaftaran',
                            style: TextStyle(
                              fontFamily: 'ConcertOne',
                              color: Colors.red,
                              fontSize: 30,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(3, 3),
                                  blurRadius: 5,
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nama Lengkap'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                  ),
                  TextFormField(
                    obscureText: this._obsecurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: !this._obsecurePassword
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() =>
                              this._obsecurePassword = !this._obsecurePassword);
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: this._obsecurePasswordConfirmation,
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: !this._obsecurePasswordConfirmation
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => this._obsecurePasswordConfirmation =
                              !this._obsecurePasswordConfirmation);
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (newValue) {},
                        value: true,
                      ),
                      Text('Setujui ketentuan dan prasarat, Pendaftaran')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
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
                  Row(children: <Widget>[
                    Expanded(child: Divider()),
                    Text('Atau'),
                    Expanded(child: Divider()),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.all(15),
                      textColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text('Batal'),
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
