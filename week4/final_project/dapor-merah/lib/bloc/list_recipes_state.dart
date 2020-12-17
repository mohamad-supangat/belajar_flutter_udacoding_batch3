part of 'list_recipes_bloc.dart';

abstract class ListRecipesState extends Equatable {
  const ListRecipesState();

  @override
  List<Object> get props => [];
}

class ListRecipesInitial extends ListRecipesState {}

class ListRecipesLoading extends ListRecipesState {}

class ListRecipesMoreLoading extends ListRecipesState {}

class ListRecipesLoaded extends ListRecipesState {
  final List<Recipe> recipes;
  final bool isLastPage;

  ListRecipesLoaded({
    @required this.recipes,
    this.isLastPage,
  });

  @override
  List<Object> get props => [recipes, isLastPage];
}

class ListRecipesError extends ListRecipesState {}
