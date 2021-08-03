import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';

abstract class TransactionRepository {

  Future<List<Transaction>> getWithFilter(TransactionFilter filter);

  Future<List<Transaction>> getWithRequestParams(
      TransactionRequestParams requestParams);

  Future<void> add(Transaction transaction);

  Future<void> update(Transaction transaction);
  
  Future<void> remove(Transaction transaction);
}
