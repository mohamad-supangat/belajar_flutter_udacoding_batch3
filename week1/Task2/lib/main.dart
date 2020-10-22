import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hantam Covid 19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var randomNumber = new Random();

  int allCase = 500;
  int deadCase = 100;
  int recoverCase = 300;
  int activeCase = 100;

  String search = '';
  String _searchTmp = '';

  void _generateCase({searchText, type}) {
    setState(() {
      if (type == 'reset') {
        allCase = 500;
        deadCase = 100;
        recoverCase = 300;
        activeCase = 100;

        search = '';
        // _searchTmp = '';
      } else {
        search = searchText;
        allCase = randomNumber.nextInt(90);
        deadCase = randomNumber.nextInt(90);
        recoverCase = randomNumber.nextInt(90);
        activeCase = randomNumber.nextInt(90);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Covid -19 NEWS',
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                              SearchText(search: search),
                              Text(
                                'Semua Kasus : ${allCase}',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Kasus kematian: ${deadCase}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Kasus sembuh : ${recoverCase}',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Semua kasus aktiv : ${activeCase}',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                ),
                              ),
                              MoreInformation(search: search),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PencarianNegara(
                  search: search,
                  onChanged: (newValue) {
                    setState(() {
                      _searchTmp = newValue;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          _generateCase(type: 'search', searchText: _searchTmp);
                        },
                        child: Text('SEARCH'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          _generateCase(type: 'reset');
                        },
                        child: Text('ALL INFORMATION'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      _generateCase(searchText: 'Srilangka', type: 'search');
                    },
                    child: Text('Updates of Srilangka'),
                  ),
                ),
                Text(
                  '!PENTING',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Text('Pencarian "Sout Korea" gunakan "Korea" saja')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PencarianNegara extends StatefulWidget {
  PencarianNegara({@required this.search, @required this.onChanged});
  final String search;
  final ValueChanged<String> onChanged;

  @override
  _PencarianNegaraState createState() => _PencarianNegaraState();
}

class _PencarianNegaraState extends State<PencarianNegara> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Pencarian Negara',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchText extends StatelessWidget {
  SearchText({@required this.search});
  String search;

  @override
  Widget build(BuildContext context) {
    if (search == '') {
      return SizedBox(
        height: 10,
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            search,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          )
        ],
      );
    }
  }
}

class MoreInformation extends StatefulWidget {
  MoreInformation({Key key, this.search}) : super(key: key);
  final String search;
  @override
  _MoreInformationState createState() => _MoreInformationState();
}

class _MoreInformationState extends State<MoreInformation> {
  var randomNumber = new Random();
  int criticalCase = 10;
  int monthCase = 20;

  @override
  void didUpdateWidget(MoreInformation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.search != oldWidget.search) {
      setState(() {
        criticalCase = randomNumber.nextInt(90);
        monthCase = randomNumber.nextInt(90);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.search == '') {
      return SizedBox(
        height: 10,
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('critical : ${criticalCase}'),
          SizedBox(height: 10),
          Text('Kasus per bulan ${monthCase}'),
        ],
      );
    }
  }
}
