import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/interactors/base_interactor.dart';
import 'package:budget_manager/src/domain/repositories/transaction_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class RemoveTransactionInteractor implements BaseInteractor<Transaction, void> {
  RemoveTransactionInteractor(this._repository);

  final TransactionRepository _repository;

  @override
  Future<void> call(Transaction transaction) {
    return _repository.remove(transaction);
  }
}
