import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_recipes_event.dart';
part 'list_recipes_state.dart';

class ListRecipesBloc extends Bloc<ListRecipesEvent, ListRecipesState> {
  ListRecipesBloc() : super(ListRecipesInitial());

  @override
  Stream<ListRecipesState> mapEventToState(
    ListRecipesEvent event,
  ) async* {}
}
