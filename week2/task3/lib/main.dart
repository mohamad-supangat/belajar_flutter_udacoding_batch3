import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Decides which theme to show.
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              child: CountingForm(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown,
          child: Icon(Icons.account_circle_sharp),
          onPressed: () async {
            const url = 'https://github.com/supangatoy';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Tidak bisa membuka url';
            }
          },
        ),
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  final ThemeMode _mode;
  ThemeMode get mode => _mode;

  ThemeModel(this._mode);
}

class CountingForm extends StatefulWidget {
  @override
  _CountingFormState createState() => _CountingFormState();
}

class _CountingFormState extends State<CountingForm> {
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate == null ? DateTime.now() : selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Apa itu',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.brown,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Counting weton ?',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.brown,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Merupakan aplikasi penghitung umur, dari tahun, bulan maupun berapa hari terhitung dari tanggal kelahiranmu',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/pakde.jpeg',
                        width: 100,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Text(
                                'Kasih tau Pakde Jowo kapan tanggal lahir kamu',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.brown,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              FlatButton.icon(
                                padding: EdgeInsets.only(
                                    left: 30, right: 30, top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.brown,
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                onPressed: () => {
                                  _selectDate(context),
                                },
                                label: Text(
                                  selectedDate == null
                                      ? 'Pilih tanggal'
                                      : '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                                ),
                                icon: Icon(Icons.calendar_today_outlined),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
