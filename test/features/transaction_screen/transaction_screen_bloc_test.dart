import 'package:bloc_test/bloc_test.dart';
import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/interactors/calculate_sum_of_transaction_interactor.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_with_request_params_interactor.dart';
import 'package:budget_manager/src/domain/interactors/remove_transaction_interactor.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_bloc.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transaction_screen_bloc_test.mocks.dart';


@GenerateMocks([
  GetTransactionWithRequestParamsInteractor,
  CalculateSumOfTransactionInteractor,
  RemoveTransactionInteractor,
])
void main() {
  group('TransactionScreenBloc', () {
    final initialState = TransactionScreenState(
      params: TransactionRequestParams(
        sort: const TransactionSortParams(),
        filter: TransactionFilter(
          maxDateOfOperation: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          minDateOfOperation: DateTime(
                  DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .subtract(
            const Duration(days: 30),
          ),
        ),
      ),
    );

    final transaction = Transaction(
      amountOfMoney: 10,
      dateCreate: DateTime(2021),
      dateOfOperation: DateTime(2021),
      subtype: const TransactionSubtype(
        id: '1',
        name: 'Name',
        type: TransactionType.revenue,
      ),
      title: 'Title',
    );

    final transactions = [
      transaction,
      transaction,
    ];

    late GetTransactionWithRequestParamsInteractor getTransactionInteractor;
    late CalculateSumOfTransactionInteractor calculateSumInteractor;
    late RemoveTransactionInteractor removeTransaction;

    TransactionScreenBloc bloc() => TransactionScreenBloc(
          calculateSumInteractor,
          getTransactionInteractor,
          removeTransaction,
        );

    setUp(() {
      getTransactionInteractor =
          MockGetTransactionWithRequestParamsInteractor();

      calculateSumInteractor = MockCalculateSumOfTransactionInteractor();

      removeTransaction = MockRemoveTransactionInteractor();
    });

    test('Initial bloc state', () {
      expect(
        bloc().state,
        initialState,
      );
    });

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState.isVisibleSearchField == true]'
      ' when we send SearchFieldEvent(true)',

      build: () {
        return bloc();
      },

      act: (bloc) => bloc.add(SearchFieldEvent(visible: true)),

      expect: () => [
        TransactionScreenState(
          params: initialState.params,
          isVisibleSearchField: true,
        )
      ],
    );

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState]'
      ' when we send TransactionScreenReloadEvent',

      build: () {
        return bloc();
      },

      act: (bloc) => bloc.add(TransactionScreenReloadEvent()),

      expect: () => [
        TransactionScreenState(
          params: initialState.params,
        ),
      ],
    );

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState.isVisibleContextMenu == true]'
      ' when we send ContextMenuEvent(true)',

      build: () {
        return bloc();
      },

      act: (bloc) => bloc.add(ContextMenuEvent(visible: true)),

      expect: () => [
        TransactionScreenState(
          params: initialState.params,
          isVisibleContextMenu: true,
        )
      ],
    );

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState.loading'
      ' = true, TransactionScreenState.transactions!=null]'
      ' when transactions is loaded successfully with init params',

      build: () {
        when(getTransactionInteractor(initialState.params))
            .thenAnswer((_) async => transactions);

        when(calculateSumInteractor(initialState.params.filter))
            .thenAnswer((_) async => 20);

        return bloc();
      },

      act: (bloc) => bloc.add(
        TransactionScreenParamsEvent(initialState.params),
      ),

      expect: () => [
        TransactionScreenState(
          params: initialState.params,
        ),
        TransactionScreenState(
          params: initialState.params,
          loading: false,
          transactions: transactions,
          sum: 20,
        ),
      ],
    );

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState.loading = false,'
      ' TransactionScreenState.error!=null]'
      ' when transactions is throws an error with init params',

      build: () {
        when(getTransactionInteractor(initialState.params))
            .thenThrow(Exception('Error'));

        when(calculateSumInteractor(initialState.params.filter))
            .thenThrow(Exception('Error'));

        return bloc();
      },

      act: (bloc) => bloc.add(
        TransactionScreenParamsEvent(initialState.params),
      ),

      expect: () => [
        TransactionScreenState(
          params: initialState.params,
        ),
        TransactionScreenState(
          params: initialState.params,
          loading: false,
          error: 'Error',
        ),
      ],
    );

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState] when '
      'transaction is removed successfully',

      build: () {
        when(removeTransaction(transaction)).thenAnswer((_) async {});

        return bloc();
      },

      act: (bloc) => bloc.add(TransactionRemoveEvent(transaction)),

      expect: () => [],
    );

    blocTest<TransactionScreenBloc, TransactionScreenState>(
      'emits [TransactionScreenState] when '
      'transaction is not removed successfully',

      build: () {
        when(removeTransaction(transaction)).thenThrow(Exception('Error'));

        return bloc();
      },

      act: (bloc) => bloc.add(TransactionRemoveEvent(transaction)),

      expect: () => [
        TransactionScreenState(
          params: initialState.params,
          loading: false,
          error: 'Error',
        ),
      ],
    );
  });
}
