import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_tags/flutter_tags.dart';

import '../models/Transaction.dart';
import '../helpers/helpers.dart';

import './NoItems.dart';
import './TransactionAction.dart';
import '../bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TransactionBloc _transactionBloc;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModalBottomSheet(),
        child: Icon(Icons.add),
      ),
      body: BlocProvider<TransactionBloc>(
        create: (context) => TransactionBloc()..add(GetTransaction()),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: _createListTransaction(context),
          ),
        ),
      ),
    );
  }

  Widget _createListTransaction(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionError) {
          return Center(
            child: NoItems(
              message: 'Gagal Mengambil data',
            ),
          );
        } else if (state is TransactionLoaded) {
          if (state.transactions.isEmpty) {
            return Center(
              child: NoItems(
                message: 'Tidak ada data tersedia',
              ),
            );
          }

          int lastIndex = state.lastPage
              ? state.transactions.length
              : state.transactions.length + 1;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.transactions.length
                  ? BottomLoader()
                  : TransactionWidget(
                      transaction: state.transactions[index],
                      first: index == 0,
                      last: index == lastIndex);
            },
            itemCount: lastIndex,
            controller: _scrollController,
          );
        } else {
          return Text('Tidak ada data ditampilkan');
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // print('asdasdasdasd');
    TransactionBloc()..add(RefreshTransaction());
  }

  void _onScroll() {
    print('scroll trigger');
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      TransactionBloc().add(GetTransaction());
    }
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

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  final bool last;
  final bool first;

  const TransactionWidget({
    Key key,
    @required this.transaction,
    this.last,
    this.first,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: first,
      isLast: last,
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        indicator: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.red[200],
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Icon(
              transaction.type == 'out'
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: transaction.type == 'out' ? Colors.green : Colors.blue,
            ),
          ),
        ),
        drawGap: true,
      ),
      beforeLineStyle: LineStyle(
        color: Colors.red[200],
      ),
      endChild: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                formatRupiah(transaction.amount),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Tags(
                itemCount: transaction.categories.length,
                itemBuilder: (int index) {
                  final item = transaction.categories[index];
                  return ItemTags(
                    textStyle: TextStyle(
                      fontSize: 12,
                    ),
                    activeColor: Colors.red,
                    elevation: 0,
                    key: Key(index.toString()),
                    index: index, // required
                    title: item,
                    pressEnabled: false,
                  );
                },
              ),
              SizedBox(height: 10),
              Text(
                transaction.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
