import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final persegiPanjang = Geometry(
  nama: 'Persegi Panjang',
  logo: 'assets/images/task5/persegiPanjang.png',
  deskripsi:
      'Persegi panjang (bahasa Inggris: rectangle) adalah bangun datar dua dimensi yang dibentuk oleh dua pasang sisi yang masing-masing sama panjang dan sejajar dengan pasangannya, dan memiliki empat buah sudut yang kesemuanya adalah sudut siku-siku.',
  rumus: [
    Rumus(
      nama: 'Keliling',
      icon: Icons.crop_square,
      unit: 'cm',
      deskripsi: 'Keliling = 2 x (Panjang + Lebar) atau K = 2x(p+l)',
      formula: '2 * (%p + %l)',
      field: [
        RumusField(
          nama: 'Panjang',
          key: 'p',
        ),
        RumusField(
          nama: 'Lebar',
          key: 'l',
        ),
      ],
    ),
    Rumus(
      nama: 'Luas',
      icon: Icons.aspect_ratio_outlined,
      deskripsi: 'Luas = Panjang x Lebar atau L = p x l',
      formula: '%p * %l',
      unit: 'cm^2',
      field: [
        RumusField(
          nama: 'Panjang',
          key: 'p',
        ),
        RumusField(
          nama: 'Lebar',
          key: 'l',
        )
      ],
    ),
  ],
);
