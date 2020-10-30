import 'package:flutter/material.dart';
import '../models/Geometry.dart';
import '../components/KalkulatorForm.dart';

class KalkulatorPage extends StatefulWidget {
  final Geometry geometry;
  KalkulatorPage(this.geometry);

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kalkulator ${widget.geometry.nama}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.geometry.nama,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(widget.geometry.deskripsi),
              SizedBox(height: 10),
              KalkulatorForm(
                logo: widget.geometry.logo,
                rumus: widget.geometry.rumus[_currentIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() {
          _currentIndex = index;
        }),
        items: widget.geometry.rumus.map((rumus) {
          return BottomNavigationBarItem(
            icon: Icon(rumus.icon),
            label: rumus.nama,
          );
        }).toList(),
      ),
    );
  }
}
