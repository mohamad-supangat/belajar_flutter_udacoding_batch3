import 'package:flutter/material.dart';

import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sayangdompet/components/NoItems.dart';
import 'package:sayangdompet/models/Recipe.dart';
import 'package:sayangdompet/bloc/bloc.dart';

import 'package:sayangdompet/bus.dart';

class ListRecipesPage extends StatefulWidget {
  @override
  _ListRecipesPageState createState() => _ListRecipesPageState();
}

class _ListRecipesPageState extends State<ListRecipesPage> {
  ScrollController _scrollController = ScrollController();
  List<Recipe> _recipes = [];
  bool _isLastPage = false;
  ListRecipesBloc _listRecipesBloc = ListRecipesBloc();

  @override
  void initState() {
    super.initState();
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });

    eventBus.on<RecipeListRefresh>().listen((event) {
      _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListRecipesBloc>(
      create: (context) => _listRecipesBloc..add(GetListRecipes()),
      child: SafeArea(
        child: BlocBuilder<ListRecipesBloc, ListRecipesState>(
          builder: (context, state) {
            print('curent state is $state');
            if (state is ListRecipesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if ((state is ListRecipesLoaded) ||
                (state is ListRecipesMoreLoading)) {
              if (state is ListRecipesLoaded) {
                _recipes.addAll(state.recipes);
                _isLastPage = state.isLastPage;
              }

              if (_recipes.length == 0) {
                return Center(
                  child: NoItems(
                    message:
                        'Tidak ada transaksi tersedia / tarik kebawah untuk refresh transaksi',
                  ),
                );
              } else {
                int itemCount = _recipes.length + (_isLastPage ? 0 : 1);
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: itemCount,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (!_isLastPage && index == itemCount - 1) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: () {
                            if (state is ListRecipesMoreLoading) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 7),
                                  Text('Memuat data'),
                                ],
                              );
                            } else {
                              SizedBox();
                            }
                          }(),
                        );
                      } else {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: RecipeWidget(
                            recipe: _recipes[index],
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            } else if (state is ListRecipesError) {
              return Center(
                child: NoItems(
                  message: 'Terjadi kesalahan, ',
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> _loadMore() async {
    if (!(_listRecipesBloc.state as ListRecipesLoaded).isLastPage &&
        !(_listRecipesBloc.state is ListRecipesMoreLoading)) {
      _listRecipesBloc..add(GetListRecipes());
    }
  }

  Future<void> _onRefresh() async {
    print('Refresh data');
    _recipes = [];
    _listRecipesBloc..add(RefreshListRecipes());
  }
}

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeWidget({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 150,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(recipe.image),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 10,
                  ),
                  Tags(
                    itemCount: recipe.categories.length,
                    alignment: WrapAlignment.start,
                    itemBuilder: (int index) {
                      final item = recipe.categories[index];
                      return ItemTags(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 65,
                        ),
                        activeColor: Colors.red,
                        elevation: 0,
                        key: Key(index.toString()),
                        index: index, // required
                        title: item,
                        pressEnabled: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
