part of 'list_recipes_bloc.dart';

abstract class ListRecipesEvent extends Equatable {
  const ListRecipesEvent();

  @override
  List<Object> get props => [];
}

class GetListRecipes extends ListRecipesEvent {}

class GetMoreListRecipes extends ListRecipesEvent {}

class RefreshListRecipes extends ListRecipesEvent {}
