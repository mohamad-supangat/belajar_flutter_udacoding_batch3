import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final lingkaran = Geometry(
  nama: 'Lingkaran',
  logo: 'assets/images/task5/lingkaran.png',
  deskripsi:
      'Lingkaran adalah bentuk yang terdiri dari semua titik dalam bidang yang berjarak tertentu dari titik tertentu, pusat; ekuivalennya adalah kurva yang dilacak oleh titik yang bergerak dalam bidang sehingga jaraknya dari titik tertentu adalah konstan. Jarak antara titik mana pun dari lingkaran dan pusat disebut jari-jari. Artikel ini adalah tentang lingkaran dalam geometri Euclidean, dan, khususnya, bidang Euclidean, kecuali jika dinyatakan sebaliknya.',
  rumus: [
    Rumus(
      nama: 'Keliling',
      icon: Icons.crop_square,
      unit: 'cm',
      deskripsi: 'Keliling = 2 x π x r (Jari - jari lingkaran)',
      formula: '2 * 22 / 7 * %r',
      field: [
        RumusField(
          nama: 'Jari - Jari',
          key: 'r',
        ),
      ],
    ),
    Rumus(
      nama: 'Luas',
      icon: Icons.aspect_ratio_outlined,
      deskripsi: 'Luas = π x r x r (jari - jari)',
      formula: '22 / 7 * %r * %r',
      unit: 'cm^2',
      field: [
        RumusField(
          nama: 'Jari - jari',
          key: 'r',
        ),
      ],
    ),
  ],
);
