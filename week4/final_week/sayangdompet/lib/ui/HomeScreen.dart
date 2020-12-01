import 'package:flutter/material.dart';
import 'TransactionAction.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModalBottomSheet(),
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text('alksdj lsakdajsdla'),
          ),
          SliverToBoxAdapter(
            child: Text('loremlkasjd lasdj asdl'),
          )
        ],
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TransactionAction(),
        );
      },
    );
  }
}
