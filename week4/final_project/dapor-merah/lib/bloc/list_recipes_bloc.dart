import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:DaporMerah/models/Recipe.dart';
import 'package:DaporMerah/repositories/recipe_repository.dart';
import 'package:meta/meta.dart';

part 'list_recipes_event.dart';
part 'list_recipes_state.dart';

class ListRecipesBloc extends Bloc<ListRecipesEvent, ListRecipesState> {
  ListRecipesBloc() : super(ListRecipesInitial());

  ListRecipesState get initialState => ListRecipesLoading();

  RecipeRepository _repository = RecipeRepository();
  List<Recipe> _recipes = [];
  bool _isLastPage;
  int _page = 1;

  @override
  Stream<ListRecipesState> mapEventToState(
    ListRecipesEvent event,
  ) async* {
    if (event is GetListRecipes) {
      yield* getListRecipes();
    }

    if (event is RefreshListRecipes) {
      _recipes = [];
      _page = 1;
      _isLastPage = null;
      yield ListRecipesLoading();
      yield* getListRecipes();
    }
  }

  Stream<ListRecipesState> getListRecipes() async* {
    try {
      if (state is ListRecipesLoaded) {
        _recipes = (state as ListRecipesLoaded).recipes;
        _isLastPage = (state as ListRecipesLoaded).isLastPage;
      }

      if (_isLastPage != null) {
        yield ListRecipesMoreLoading();
      } else {
        yield ListRecipesLoading();
      }

      if (_recipes.length == 0 || _isLastPage == null || !_isLastPage) {
        Map req = await _repository.getListRecipes(page: _page);
        _recipes = (req['recipes']);
        _isLastPage = req['isLastPage'];

        if (!req['isLastPage']) {
          _page++;
        }
      }

      yield ListRecipesLoaded(
        recipes: _recipes,
        isLastPage: _isLastPage,
      );
    } catch (_) {
      yield ListRecipesError();
    }
  }
}
