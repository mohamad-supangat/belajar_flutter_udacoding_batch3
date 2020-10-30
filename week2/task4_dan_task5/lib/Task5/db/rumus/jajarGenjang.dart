import 'package:flutter/material.dart';
import '../../models/Geometry.dart';
import '../../models/Rumus.dart';

final jajarGenjang = Geometry(
  nama: 'Jajar Genjang',
  logo: 'assets/images/task5/jajargenjang.png',
  deskripsi:
      'Jajar genjang atau jajaran genjang (bahasa Inggris: parallelogram) adalah bangun datar dua dimensi yang dibentuk oleh dua pasang rusuk yang masing-masing sama panjang dan sejajar dengan pasangannya, dan memiliki dua pasang sudut yang masing-masing sama besar dengan sudut di hadapannya.',
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
      deskripsi: 'Luas = alas x tinggi atau L = a x t',
      formula: '%a * %t',
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
