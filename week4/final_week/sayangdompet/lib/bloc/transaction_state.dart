part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionMoreLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final bool isLastPage;

  const TransactionLoaded({
    @required this.transactions,
    @required this.isLastPage,
  });

  @override
  List<Object> get props => [transactions, isLastPage];
}

class TransactionError extends TransactionState {}
