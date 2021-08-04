import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_subtype_by_type_interactor.dart';
import 'package:budget_manager/src/features/transaction_subtypes_list/transaction_subtype_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionSubtypeBloc
    extends Bloc<TransactionType?, TransactionSubtypeState> {
  TransactionSubtypeBloc(this._interactor)
      : super(TransactionSubtypeLoadingState());

  final GetTransactionSubtypeByTypeInteractor _interactor;

  @override
  Stream<TransactionSubtypeState> mapEventToState(
      [TransactionType? event]) async* {
    yield TransactionSubtypeLoadingState();
    try {
      final subtypes = await _interactor(event);

      yield TransactionSubtypeLoadedState(subtypes);
    } on Exception catch (error) {
      yield TransactionSubtypeErrorState('$error');
    }
  }
}
