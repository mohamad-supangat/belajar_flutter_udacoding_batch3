part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransaction extends TransactionEvent {}

class GetMoreTransaction extends TransactionEvent {
  final int page, limit;

  GetMoreTransaction({@required this.page, this.limit});

  @override
  List<Object> get props => [page, limit];
}
