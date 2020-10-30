import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final persegi = Geometry(
  nama: 'Persegi',
  logo: 'assets/images/task5/persegi.png',
  deskripsi:
      'Persegi adalah bangun datar dua dimensi yang dibentuk oleh empat buah rusuk  yang sama panjang dan memiliki empat buah sudut yang kesemuanya adalah sudut siku-siku. ',
  rumus: [
    Rumus(
      nama: 'Keliling',
      icon: Icons.crop_square,
      unit: 'cm',
      deskripsi:
          'Keliling = Sisi x 4 atau K = 4a atau K = 4s atau K = s + s + s + s',
      formula: '%s * 4',
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
      deskripsi: 'Luas = Sisi x Sisi atau L = s x s',
      formula: '%s * %s',
      unit: 'cm^2',
      field: [
        RumusField(
          nama: 'Sisi',
          key: 's',
        ),
      ],
    ),
  ],
);
