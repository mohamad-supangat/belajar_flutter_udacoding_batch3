import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final belahKetupat = Geometry(
  nama: 'Belah Ketupat',
  logo: 'assets/images/task5/belahketupat.png',
  deskripsi:
      'Belah ketupat (bahasa Inggris: rhombus) adalah bangun datar dua dimensi yang dibentuk oleh empat buah masing-masing sama besar dengan sudut di hadapannya.',
  rumus: [
    Rumus(
      nama: 'Keliling',
      icon: Icons.crop_square,
      unit: 'cm',
      deskripsi: 'K = 4 x sisi',
      formula: '4 * %s',
      field: [
        RumusField(
          nama: 'Sisi',
          key: 's',
        ),
      ],
    ),
    Rumus(
      nama: 'Luas',
      icon: Icons.aspect_ratio_outlined,
      deskripsi: 'Luas = 1/2 x diagonal 1 x diagonal 2',
      formula: '1/2 * %d1 * %d2',
      unit: 'cm^2',
      field: [
        RumusField(
          nama: 'Diagonal 1',
          key: 'd1',
        ),
        RumusField(
          nama: 'Diagonal 2',
          key: 'd2',
        ),
      ],
    ),
  ],
);
