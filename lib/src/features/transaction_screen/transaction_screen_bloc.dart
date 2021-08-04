import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/domain/interactors/calculate_sum_of_transaction_interactor.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_with_request_params_interactor.dart';
import 'package:budget_manager/src/domain/interactors/remove_transaction_interactor.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreenBloc
    extends Bloc<TransactionScreenEvent, TransactionScreenState> {
  TransactionScreenBloc(
    this._calculateSumInteractor,
    this._getTransactionInteractor,
    this._removeTransaction,
  ) : super(
          TransactionScreenState(
            params: TransactionRequestParams(
              sort: const TransactionSortParams(),
              filter: TransactionFilter(
                maxDateOfOperation: DateTime.now(),
                minDateOfOperation: DateTime.now().subtract(
                  const Duration(days: 30),
                ),
              ),
            ),
          ),
        );

  final GetTransactionWithRequestParamsInteractor _getTransactionInteractor;
  final CalculateSumOfTransactionInteractor _calculateSumInteractor;
  final RemoveTransactionInteractor _removeTransaction;

  @override
  Stream<TransactionScreenState> mapEventToState(
      TransactionScreenEvent event) async* {
    if (event is SearchFieldEvent) {
      yield state.copyWith(isVisibleSearchField: event.visible);

    } else if (event is TransactionScreenParamsEvent) {
      yield* _loadData(event.params);

    } else if (event is ContextMenuEvent) {
      yield state.copyWith(isVisibleContextMenu: event.visible);

    } else if (event is TransactionRemoveEvent) {
      yield* _removeTransactionStream(event);

    } else if (event is TransactionScreenReloadEvent) {
      yield* _loadData(state.params);
    }
  }

  Stream<TransactionScreenState> _removeTransactionStream(
      TransactionRemoveEvent event) async* {
    try {
      await _removeTransaction(event.transaction);

    } on Exception catch (error) {
      yield state.copyWith(
        error: '$error',
      );
    }
  }

  Stream<TransactionScreenState> _loadData(
      TransactionRequestParams? params) async* {
    yield state.copyWith(loading: true);

    try {
      final transactions = await _getTransactionInteractor(params!);
      final sum = await _calculateSumInteractor(params.filter);

      yield state.copyWith(
          params: params, sum: sum, transactions: transactions, loading: false);
          
    } on Exception catch (error) {
      yield state.copyWith(
        error: '$error',
        loading: false,
      );
    }
  }
}
