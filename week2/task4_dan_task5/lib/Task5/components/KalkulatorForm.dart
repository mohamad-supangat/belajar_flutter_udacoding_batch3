import 'package:flutter/material.dart';
import '../models/Rumus.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:developer';

class KalkulatorForm extends StatefulWidget {
  final String logo;
  final Rumus rumus;

  KalkulatorForm({
    this.logo,
    this.rumus,
  });
  @override
  _KalkulatorFormState createState() => _KalkulatorFormState();
}

class _KalkulatorFormState extends State<KalkulatorForm> {
  final _formKey = GlobalKey<FormState>();
  String _hasil;
  String _kalkulasiRumus = '';

  Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.rumus.field.forEach((field) {
      _controllers[field.key] = TextEditingController();
    });
  }

  @override
  void didUpdateWidget(KalkulatorForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rumus != oldWidget.rumus) {
      setState(() {
        _controllers = {};
        _hasil = null;
        widget.rumus.field.forEach((field) {
          _controllers[field.key] = TextEditingController();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.rumus.nama,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          widget.rumus.deskripsi,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Image.asset(widget.logo),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.rumus.field.map((field) {
                        return TextFormField(
                          controller: _controllers[field.key],
                          decoration: InputDecoration(
                            labelText: '${field.nama} *',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (String arg) {
                            if (arg == '')
                              return '${field.nama} tidak boleh kosong';
                            else if (double.parse(arg) <= 0)
                              return '${field.nama} tidak boleh kurang sama dengan 0';
                            else
                              return null;
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Divider(),
        RaisedButton(
          color: Colors.blueGrey,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _prosesHitung();
            }
          },
          child: Text('Hitung'),
        ),
        Divider(),
        Visibility(
          visible: (_hasil != null),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.blueGrey,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diketahui:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  ...widget.rumus.field.map((field) {
                    return Text(
                      '${field.nama} : ${_controllers[field.key].text}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Masukan kedalam rumus:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${widget.rumus.nama} = ${_kalkulasiRumus}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hasil =  ${_hasil} ${widget.rumus.unit}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _prosesHitung() {
    String _formula = widget.rumus.formula;
    Parser p = Parser();
    ContextModel cm = ContextModel();
    widget.rumus.field.forEach((field) {
      _formula = _formula.replaceAll(
        '%${field.key}',
        _controllers[field.key].text,
      );
    });

    setState(() {
      _kalkulasiRumus = _formula;
      _hasil = p.parse(_formula).evaluate(EvaluationType.REAL, cm).toString();
    });
  }
}
