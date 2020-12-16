part of 'list_recipes_bloc.dart';

abstract class ListRecipesState extends Equatable {
  const ListRecipesState();

  @override
  List<Object> get props => [];
}

class ListRecipesInitial extends ListRecipesState {}

class ListRecipesMoreLoading extends ListRecipesState {}

class ListRecipesLoaded extends TransactionState {
  final List<Transaction> transactions;
  final bool isLastPage;

  const TransactionLoaded({
    @required this.transactions,
    @required this.isLastPage,
  });

  @override
  List<Object> get props => [transactions, isLastPage];
}

class ListRecipesError extends TransactionState {}
