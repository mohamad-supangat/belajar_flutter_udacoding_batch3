import 'package:dio/dio.dart';

import 'package:sayangdompet/helpers/helpers.dart';
import 'package:sayangdompet/models/Transaction.dart';

class TransactionRepository {
  Future<Map> getTransactions({int page, int limit = 10}) async {
    try {
      final Response response =
          await callApi().get('/transaction/lists?page=$page&limit=$limit');
      return {
        'transactions':
            transactionFromJson(response.data['transactions']['data']),
        'isLastPage': response.data['transactions']['next_page_url'] == null,
      };
    } catch (e) {
      throw Exception('error fetching Transaction');
    }
  }
}
