import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final segitiga = Geometry(
  nama: 'Segitiga',
  logo: 'assets/images/task5/segitiga.png',
  deskripsi:
      'Sebuah segitiga adalah poligon dengan tiga ujung dan tiga simpul. Ini adalah salah satu bentuk dasar dalam geometri.',
  rumus: [
    Rumus(
      nama: 'Keliling',
      icon: Icons.crop_square,
      unit: 'cm',
      deskripsi: 'K = a + b + c',
      formula: 'a + b + c',
      field: [
        RumusField(
          nama: 'Sisi a',
          key: 'a',
        ),
        RumusField(
          nama: 'Sisi b',
          key: 'b',
        ),
        RumusField(
          nama: 'Sisi c',
          key: 'c',
        ),
      ],
    ),
    Rumus(
      nama: 'Luas',
      icon: Icons.aspect_ratio_outlined,
      deskripsi: 'Luas = 1/2 x alas x tinggi',
      formula: '1/2 * %a * %t',
      unit: 'cm^2',
      field: [
        RumusField(
          nama: 'Alas',
          key: 'a',
        ),
        RumusField(
          nama: 'Tinggi',
          key: 't',
        ),
      ],
    ),
  ],
);
