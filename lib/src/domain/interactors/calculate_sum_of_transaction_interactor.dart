import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/interactors/base_interactor.dart';
import 'package:budget_manager/src/domain/repositories/transaction_repository.dart';

class CalculateSumOfTransactionInteractor
    implements BaseInteractor<TransactionFilter, double> {
  CalculateSumOfTransactionInteractor(this._repository);

  final TransactionRepository _repository;

  @override
  Future<double> call(TransactionFilter filter) async {
    return _repository.getWithFilter(filter).then((transactios) => transactios
        .map((transaction) => transaction.amountOfMoney)
        .toList()
        .fold<double>(
            0.0, (previousValue, element) => previousValue + element));
  }
}
