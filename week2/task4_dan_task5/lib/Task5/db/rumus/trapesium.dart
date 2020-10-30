import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final trapesium = Geometry(
  nama: 'Trapesium',
  logo: 'assets/images/task5/trapesium.png',
  deskripsi:
      'Trapesium adalah bangun datar dua dimensi yang dibentuk oleh empat buah rusuk yang dua di antaranya saling sejajar namun tidak sama panjang.',
  rumus: [
    Rumus(
      nama: 'Keliling',
      icon: Icons.crop_square,
      unit: 'cm',
      deskripsi: 'K = a + b + c + d',
      formula: '%a + %b + %c + %d',
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
        RumusField(
          nama: 'Sisi d',
          key: 'd',
        ),
      ],
    ),
    Rumus(
      nama: 'Luas',
      icon: Icons.aspect_ratio_outlined,
      deskripsi: 'Luas = (Sisi a + Sisi b) / 2 x t',
      formula: '(%a + %b) / 2 * %t',
      unit: 'cm^2',
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
          nama: 'Tinggi',
          key: 't',
        ),
      ],
    ),
  ],
);
