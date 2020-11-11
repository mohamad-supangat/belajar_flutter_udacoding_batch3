import 'package:flutter/material.dart';

List<BottomNavigationBarItem> mainBottomNavigationBars() {
  return [
    BottomNavigationBarItem(
      label: 'Berita Kesehatan',
      icon: Icon(Icons.analytics_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Kamus Istilah',
      icon: Icon(Icons.book_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Profile Saya',
      icon: Icon(Icons.account_circle_outlined),
    ),
  ];
}
