part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactonMoreLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final bool lastPage;

  const TransactionLoaded({
    @required this.transactions,
    @required this.lastPage,
  });

  @override
  List<Object> get props => [transactions, lastPage];

  @override
  String toString() =>
      'PostSuccess { transactions: ${transactions.length}, lastPage: $lastPage }';
}

class TransactionError extends TransactionState {}
