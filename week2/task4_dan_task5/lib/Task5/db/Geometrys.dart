import '../models/Geometry.dart';
import '../models/Rumus.dart';

final geometrys = [
  Geometry(
    nama: 'Persegi',
    deskripsi:
        'Persegi adalah bangun datar dua dimensi yang dibentuk oleh empat buah rusuk  yang sama panjang dan memiliki empat buah sudut yang kesemuanya adalah sudut siku-siku. ',
    rumus: [
      Rumus(
        nama: 'Keliling',
        deskripsi: 'K = 4a atau K = 4s atau K = s + s + s + s',
        field: [
          RumusField(
            nama: 'Sisi',
            key: 's',
          ),
        ],
      ),
    ],
  ),
];