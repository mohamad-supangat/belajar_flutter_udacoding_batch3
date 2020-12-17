import 'package:dio/dio.dart';

import 'package:DaporMerah/helpers/helpers.dart';
import 'package:DaporMerah/models/Recipe.dart';

class RecipeRepository {
  Future<Map> getListRecipes({int page, int limit = 10}) async {
    try {
      final Response response =
          await callApi().get('/recipe/lists?page=$page&limit=$limit');
      return {
        'recipes': transactionFromJson(response.data['recipes']['data']),
        'isLastPage': response.data['recipes']['next_page_url'] == null,
      };
    } catch (e) {
      throw Exception('error fetching Transaction');
    }
  }
}
