import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../models/Transaction.dart';
import '../repositories/transaction_respository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial());

  TransactionRepository _repository = TransactionRepository();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    final currentState = state;
    if (event is GetTransaction && !_isLastPage(currentState)) {
      try {
        if (currentState is TransactionInitial) {
          List<Transaction> transactions =
              await _repository.getTransactions(page: 1);
          yield TransactionLoaded(transactions: transactions, lastPage: false);
          return;
        }

        if (currentState is TransactionLoaded) {
          print('load more data');

          List<Transaction> transactions =
              await _repository.getTransactions(page: 1);
          yield TransactionLoaded(
            transactions: currentState.transactions + transactions,
            lastPage: false,
          );
        }
      } catch (_) {
        yield TransactionError();
      }
    }

    if (event is RefreshTransaction) {
      print('asdasdasd');
    }
  }

  bool _isLastPage(TransactionState state) =>
      state is TransactionLoaded && state.lastPage;
}
