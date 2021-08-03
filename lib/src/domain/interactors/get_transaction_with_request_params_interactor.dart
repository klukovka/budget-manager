import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/interactors/base_interactor.dart';
import 'package:budget_manager/src/domain/repositories/transaction_repository.dart';

class GetTransactionWithRequestParamsInteractor
    implements BaseInteractor<TransactionRequestParams, List<Transaction>> {
  GetTransactionWithRequestParamsInteractor(this._repository);

  final TransactionRepository _repository;

  @override
  Future<List<Transaction>> call(TransactionRequestParams requestParams) async {
    return _repository.getWithRequestParams(requestParams);
  }
}
