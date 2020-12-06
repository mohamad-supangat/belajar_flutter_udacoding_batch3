import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sayangdompet/helpers/helpers.dart';
import 'package:sayangdompet/ui/NoItems.dart';
import 'package:sayangdompet/ui/PesanMenarik.dart';
import 'package:sayangdompet/bus.dart';

class DetailTransactions extends StatefulWidget {
  @override
  _DetailTransactionsState createState() => _DetailTransactionsState();
}

class _DetailTransactionsState extends State<DetailTransactions> {
  bool _isLoading = true;
  Total _total;
  Map<String, List<FlSpot>> _chart = {
    'in': [
      FlSpot(0, 0),
    ],
    'out': [
      FlSpot(0, 0),
    ]
  };

  @override
  void initState() {
    super.initState();
    _getData();
    eventBus.on<TransactionListRefresh>().listen((event) {
      _getData();
    });
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
            padding: EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: _getData,
              child: ListView(
                children: [
                  PesanMenarik(
                    totalMasuk: _total.masuk,
                    totalKeluar: _total.keluar,
                  ),
                  SizedBox(height: 20),
                  _detailTotal(),
                  SizedBox(height: 20),
                  _chart['in'].isEmpty || _chart['out'].isEmpty
                      ? SizedBox()
                      : _generateChart(),
                ],
              ),
            ),
          ),
        );
      }
    }
  }

  Widget _generateChart() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Grafik Riwayat Transaksi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 2,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.black.withOpacity(0.8),
                    ),
                    touchCallback: (LineTouchResponse touchResponse) {},
                    handleBuiltInTouches: true,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(showTitles: false),
                    leftTitles: SideTitles(showTitles: false),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _chart['in'].toList(),
                      colors: [
                        Colors.green,
                      ],
                      isCurved: true,
                      // barWidth: 8,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                    ),
                    LineChartBarData(
                      spots: _chart['out'].toList(),
                      colors: [
                        Colors.red,
                      ],
                      isCurved: true,
                      // barWidth: 8,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detailTotal() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rekap Transaksi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
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
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 19),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total Uang Keluar',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      formatRupiah(_total.keluar),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(
              indent: 20,
              height: 30,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.assignment_sharp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 19),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total Sisa Uang',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      formatRupiah(_total.sisa),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue,
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

  Future<void> _getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await callApi().get('/transaction/statistic');
      Map data = response.data;
      List<FlSpot> _tmpChartIn = [];
      List<FlSpot> _tmpChartOut = [];

      data['chart']['in'].forEach((item) {
        _tmpChartIn.add(
            FlSpot(double.parse(item['date']), double.parse(item['amount'])));
      });
      data['chart']['out'].forEach((item) {
        _tmpChartOut.add(
            FlSpot(double.parse(item['date']), double.parse(item['amount'])));
      });

      setState(() {
        _total = Total(
          masuk: data['total']['in'],
          keluar: data['total']['out'],
          sisa: data['total']['in'] - data['total']['out'],
        );

        _chart['in'] = _tmpChartIn;
        _chart['out'] = _tmpChartOut;
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
