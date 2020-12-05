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
  // ListF<>
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
            child: RefreshIndicator(
              onRefresh: _getData,
              child: ListView(
                children: [
                  _detailTotal(),
                  SizedBox(height: 10),
                  _generateChart(),
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
                      spots: [
                        FlSpot(1, 1),
                        FlSpot(3, 1.5),
                        FlSpot(5, 1.4),
                        FlSpot(7, 3.4),
                        FlSpot(10, 2),
                        FlSpot(12, 2.2),
                        FlSpot(13, 1.8),
                        FlSpot(1, 1),
                        FlSpot(3, 1.5),
                        FlSpot(5, 1.4),
                        FlSpot(7, 3.4),
                        FlSpot(10, 2),
                        FlSpot(12, 2.2),
                        FlSpot(13, 1.8),
                        FlSpot(1, 1),
                        FlSpot(3, 1.5),
                        FlSpot(5, 1.4),
                        FlSpot(7, 3.4),
                        FlSpot(10, 2),
                        FlSpot(12, 2.2),
                        FlSpot(13, 1.8),
                        FlSpot(1, 1),
                        FlSpot(3, 1.5),
                        FlSpot(5, 1.4),
                        FlSpot(7, 3.4),
                        FlSpot(10, 2),
                        FlSpot(12, 2.2),
                        FlSpot(13, 1.8),
                        FlSpot(1, 1),
                        FlSpot(3, 1.5),
                        FlSpot(5, 1.4),
                        FlSpot(7, 3.4),
                        FlSpot(10, 2),
                        FlSpot(12, 2.2),
                        FlSpot(300, 1.8),
                      ],
                      colors: [
                        const Color(0xff4af699),
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
                      spots: [
                        FlSpot(1, 30),
                        FlSpot(3, 2.8),
                        FlSpot(7, 1.2),
                        FlSpot(10, 2.8),
                        FlSpot(12, 2.6),
                        FlSpot(13, 3.9),
                      ],
                      colors: [
                        const Color(0xffaa4cfc),
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
                      spots: [
                        FlSpot(1, 2.8),
                        FlSpot(3, 1.9),
                        FlSpot(6, 3),
                        FlSpot(10, 1.3),
                        FlSpot(13, 2.5),
                      ],
                      colors: const [
                        Color(0xff27b6fc),
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
                    )
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
