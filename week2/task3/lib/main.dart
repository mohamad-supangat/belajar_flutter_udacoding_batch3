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
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
                elevation: 5,
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
              SizedBox(
                height: 20,
              ),
              CountingCardProsess(
                dateOfBird: selectedDate,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CountingCardProsess extends StatefulWidget {
  CountingCardProsess({Key key, @required this.dateOfBird}) : super(key: key);
  DateTime dateOfBird;

  @override
  _CountingCardProsessState createState() => _CountingCardProsessState();
}

class _CountingCardProsessState extends State<CountingCardProsess> {
  final DateTime dateNow = new DateTime.now();
  int differenceDay = 0;
  String ageComputed = '0 tahun 0 bulan 0 hari';

  @override
  void didUpdateWidget(CountingCardProsess oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dateOfBird != null) {
      setState(() {
        // hitung total perbandingan hari
        differenceDay = dateNow.difference(widget.dateOfBird).inDays;
        double years = (differenceDay / 365);
        double month = ((differenceDay % 365) / 30.5);
        double days = ((differenceDay % 365) % 30.5);
        ageComputed =
            '${years.floor()} Tahun ${month.floor()} Bulan ${days.floor()} Hari';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dateOfBird == null) {
      return Column(
        children: [
          Divider(),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Aplikasi week2 Task3 udacoding flutter batch 3 | Perhitungan umur | Mohamad Supangat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      );
    } else {
      return Card(
        color: Colors.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Text(
                'Kata pakde jowo total umur kamu jika di hitung berdasarkan hari yaitu :',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${differenceDay.toString()} Hari',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Kalau di sederhanakan maka hasilnya :',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                ageComputed,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
