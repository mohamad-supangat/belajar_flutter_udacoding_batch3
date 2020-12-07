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
  TransactionBloc() : super(TransactionLoading());

  // @override
  TransactionState get initialState => TransactionLoading();

  TransactionRepository _repository = TransactionRepository();
  List<Transaction> _transactions = [];
  bool _isLastPage;
  int _page = 1;

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is GetTransaction) {
      yield* getTransaction();
    }

    if (event is RefreshTransaction) {
      _transactions = [];
      _page = 1;
      _isLastPage = null;
      yield TransactionLoading();
      yield* getTransaction();
    }
  }

  Stream<TransactionState> getTransaction() async* {
    try {
      if (state is TransactionLoaded) {
        _transactions = (state as TransactionLoaded).transactions;
        _isLastPage = (state as TransactionLoaded).isLastPage;
      }

      if (_isLastPage != null) {
        yield TransactionMoreLoading();
      } else {
        yield TransactionLoading();
      }

      if (_transactions.length == 0 || _isLastPage == null || !_isLastPage) {
        Map req = await _repository.getTransactions(page: _page);
        _transactions = (req['transactions']);
        _isLastPage = req['isLastPage'];

        if (!req['isLastPage']) {
          _page++;
        }
      }

      yield TransactionLoaded(
        transactions: _transactions,
        isLastPage: _isLastPage,
      );
    } catch (_) {
      yield TransactionError();
    }
  }
}
