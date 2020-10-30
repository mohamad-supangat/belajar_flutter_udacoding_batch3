import 'package:flutter/material.dart';

class RumusField {
  final String nama;
  final String key;
  RumusField({
    this.nama,
    this.key,
  });
}

class Rumus {
  final String nama;
  final icon;
  final String deskripsi;
  final List<RumusField> field;
  Rumus({
    this.nama,
    this.deskripsi,
    this.field,
    this.icon,
  });
}
