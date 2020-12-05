import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sayangdompet/helpers/helpers.dart';
import 'package:sayangdompet/ui/NoItems.dart';

class DetailTransactions extends StatefulWidget {
  @override
  _DetailTransactionsState createState() => _DetailTransactionsState();
}

class _DetailTransactionsState extends State<DetailTransactions> {
  bool _isLoading = true;
  Total _total;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 30),
            Text('Sedang mengambil data')
          ],
        ),
      );
    } else {
      if (_total == null) {
        return Center(
          child: NoItems(
            message: 'Kesalahan Sistem',
          ),
        );
      } else {
        return SafeArea(
          child: Container(
            child: ListView(
              children: [_detailTotal()],
            ),
          ),
        );
      }
    }
  }

  Widget _detailTotal() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 19),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total Uang Masuk',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      formatRupiah(_total.masuk),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await callApi().get('/transaction/statistic');
      Map data = response.data;

      setState(() {
        _total = Total(
          masuk: data['total']['in'],
          keluar: data['total']['out'],
          sisa: data['total']['in'] - data['total']['out'],
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class Total {
  int masuk;
  int keluar;
  int sisa;
  Total({this.masuk, this.keluar, this.sisa});
}
