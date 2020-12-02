import 'package:dio/dio.dart';

import '../helpers/api.dart';
import '../models/Transaction.dart';

class TransactionRepository {
  Future<List<Transaction>> getTransactions({int page, int limit = 10}) async {
    try {
      final Response response =
          await callApi().get('/transaction/lists?page=$page&limit=$limit');
      return transactionFromJson(response.data['transactions']['data']);
    } catch (e) {
      throw Exception('error fetching Transaction');
    }
  }
}
