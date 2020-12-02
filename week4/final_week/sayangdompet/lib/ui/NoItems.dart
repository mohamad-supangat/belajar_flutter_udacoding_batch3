import 'package:flutter/material.dart';

class NoItems extends StatelessWidget {
  final String message;
  NoItems({
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.grey,
            size: 100,
          ),
          SizedBox(
            height: 12,
          ),
          Text(message),
        ],
      ),
    );
  }
}
