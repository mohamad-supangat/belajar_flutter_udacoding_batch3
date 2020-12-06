import 'package:flutter/material.dart';

class PesanMenarik extends StatefulWidget {
  final int totalMasuk;
  final int totalKeluar;

  PesanMenarik({
    @required this.totalMasuk,
    @required this.totalKeluar,
  });

  @override
  _PesanMenarikState createState() => _PesanMenarikState();
}

class _PesanMenarikState extends State<PesanMenarik> {
  String _pesan = '';
  MaterialColor _backgroundColor = Colors.blue;
  IconData _icon = Icons.add;

  @override
  Widget build(BuildContext context) {
    if (widget.totalMasuk == 0 && widget.totalKeluar == 0) {
      _icon = Icons.add;
      _backgroundColor = Colors.blue;
      _pesan =
          'Hai !!, silahkan buat transaksi pertamamu dengan klik tombol tambah di bawah kanan';
    } else {
      if (widget.totalMasuk < widget.totalKeluar) {
        _icon = Icons.sentiment_very_dissatisfied;
        _backgroundColor = Colors.red;
        _pesan =
            'Yah pengeluaran kamu lebih besar dari pemasukan, yuk kelola dengan benar agar tidak bangkrut';
      } else {
        _icon = Icons.emoji_emotions_outlined;
        _backgroundColor = Colors.green;
        _pesan = 'Keuangan kamu sedang baik, lanjutkan terus transaksi kamu';
      }
    }

    return Card(
      color: _backgroundColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              _icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                _pesan,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
