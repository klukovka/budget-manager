import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/interactors/base_interactor.dart';
import 'package:budget_manager/src/domain/repositories/transaction_subtype_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetTransactionSubtypeByTypeInteractor
    implements BaseInteractor<TransactionType?, List<TransactionSubtype>> {
  GetTransactionSubtypeByTypeInteractor(this._repository);

  final TransactionSubtypeRepository _repository;

  @override
  Future<List<TransactionSubtype>> call([TransactionType? type]) async {
    return _repository.getByType(type);
  }
}
