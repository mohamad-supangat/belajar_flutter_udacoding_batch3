import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';

import 'package:sayangdompet/ui/NoItems.dart';
import 'package:sayangdompet/models/Transaction.dart';
import 'package:sayangdompet/bloc/bloc.dart';
import 'package:sayangdompet/helpers/helpers.dart';

class ListTransactions extends StatefulWidget {
  @override
  _ListTransactionsState createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {
  final TransactionBloc _bloc = TransactionBloc();
  ScrollController _scrollController = ScrollController();
  List<Transaction> _transactions = [];
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (context) => _bloc..add(GetTransaction()),
      child: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            print('curent state is $state');
            if (state is TransactionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if ((state is TransactionLoaded) ||
                (state is TransactionMoreLoading)) {
              if (state is TransactionLoaded) {
                _transactions.addAll(state.transactions);
                _isLastPage = state.isLastPage;
              }

              if (_transactions.length == 0) {
                return Center(
                  child: NoItems(
                    message: 'Tidak ada item tersedia',
                  ),
                );
              } else {
                int itemCount = _transactions.length + (_isLastPage ? 0 : 1);
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: itemCount,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (!_isLastPage && index == itemCount - 1) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: () {
                            if (state is TransactionMoreLoading) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 7),
                                  Text('Memuat data'),
                                ],
                              );
                            } else {
                              SizedBox();
                            }
                          }(),
                        );
                      } else {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: TransactionWidget(
                            transaction: _transactions[index],
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            } else if (state is TransactionError) {
              return Center(
                child: NoItems(
                  message: 'Terjadi kesalahan, ',
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> _loadMore() async {
    if (!(_bloc.state as TransactionLoaded).isLastPage &&
        !(_bloc.state is TransactionMoreLoading)) {
      _bloc..add(GetTransaction());
    }
  }

  Future<void> _onRefresh() async {
    print('Refresh data');
    _bloc..add(RefreshTransaction());
  }
}

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionWidget({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: transaction.type == 'in' ? Colors.green : Colors.blue,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(
                transaction.type == 'in'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      formatRupiah(transaction.amount),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Tags(
                    itemCount: transaction.categories.length,
                    alignment: WrapAlignment.center,
                    itemBuilder: (int index) {
                      final item = transaction.categories[index];
                      return ItemTags(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 65,
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
                    transaction.description + transaction.description,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.w200,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
