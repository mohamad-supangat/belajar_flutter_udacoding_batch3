import 'package:flutter/material.dart';
import '../models/Geometry.dart';
import '../models/Rumus.dart';

final List geometrysDb = [
  Geometry(
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
  ),
  Geometry(
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
  ),
];
