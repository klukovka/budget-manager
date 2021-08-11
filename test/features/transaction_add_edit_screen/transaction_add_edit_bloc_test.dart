import 'package:bloc_test/bloc_test.dart';
import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/interactors/add_transaction_interactor.dart';
import 'package:budget_manager/src/domain/interactors/update_transaction_interactor.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_bloc.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_event.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transaction_add_edit_bloc_test.mocks.dart';

@GenerateMocks([
  AddTransactionInteractor,
  UpdateTransactionInteractor,
])
void main() {
  group('TransactionAddEditBloc', () {
    const _titleInvalid = 'Title must contain more than 3 characters';
    const _amountInvalid = 'Money amount must be a number';
    const _subtypeInvalid = 'Choose the type of operation';

    final date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final initialState = TransactionAddEditState(
      date: date,
      titleInvalid: _titleInvalid,
      amountInvalid: _amountInvalid,
      subtypeInvalid: _subtypeInvalid,
    );

    const subtype = TransactionSubtype(
      id: '1',
      name: 'Name',
      type: TransactionType.revenue,
    );

    final transaction = Transaction(
      amountOfMoney: 10,
      dateCreate: DateTime(2021),
      dateOfOperation: DateTime(2021),
      subtype: subtype,
      title: 'Title',
      id: '3',
    );

    late AddTransactionInteractor _addInteractor;
    late UpdateTransactionInteractor _updateInteractor;

    TransactionAddEditBloc bloc() => TransactionAddEditBloc(
          _addInteractor,
          _updateInteractor,
        );

    setUp(() {
      _addInteractor = MockAddTransactionInteractor();
      _updateInteractor = MockUpdateTransactionInteractor();
    });

    test('Initial bloc state', () {
      expect(
        bloc().state,
        initialState,
      );
    });

    group('TransactionChooseSubtypeEvent', () {
      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event',
        build: () => bloc(),
        act: (bloc) => bloc.add(
          TransactionChooseSubtypeEvent(subtype),
        ),
        expect: () => [
          TransactionAddEditState(
            date: date,
            titleInvalid: _titleInvalid,
            amountInvalid: _amountInvalid,
            subtype: subtype,
          ),
        ],
      );
    });

    group('TransactionChangeTitleEvent', () {
      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event is successful',
        build: () => bloc(),
        act: (bloc) => bloc.add(
          TransactionChangeTitleEvent('title'),
        ),
        expect: () => [
          TransactionAddEditState(
            date: date,
            amountInvalid: _amountInvalid,
            subtypeInvalid: _subtypeInvalid,
            title: 'title',
          ),
        ],
      );

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event is badly',
        build: () => bloc(),
        act: (bloc) {
          bloc
            ..add(TransactionChangeTitleEvent('title'))
            ..add(TransactionChangeTitleEvent('1'));
        },
        expect: () => [
          TransactionAddEditState(
            date: date,
            amountInvalid: _amountInvalid,
            subtypeInvalid: _subtypeInvalid,
            title: 'title',
          ),
          TransactionAddEditState(
            date: date,
            amountInvalid: _amountInvalid,
            subtypeInvalid: _subtypeInvalid,
            titleInvalid: _titleInvalid,
            title: 'title',
          ),
        ],
      );
    });

    group('TransactionChangeAmountEvent', () {
      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event is successful ',
        build: () => bloc(),
        act: (bloc) => bloc.add(
          TransactionChangeAmountEvent('111'),
        ),
        expect: () => [
          TransactionAddEditState(
            date: date,
            subtypeInvalid: _subtypeInvalid,
            titleInvalid: _titleInvalid,
            amount: 111,
          ),
        ],
      );

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event is badly',
        build: () => bloc(),
        act: (bloc) {
          bloc
            ..add(TransactionChangeAmountEvent('111'))
            ..add(TransactionChangeAmountEvent('tyuhijo'));
        },
        expect: () => [
          TransactionAddEditState(
            date: date,
            subtypeInvalid: _subtypeInvalid,
            titleInvalid: _titleInvalid,
            amount: 111,
          ),
          TransactionAddEditState(
            date: date,
            subtypeInvalid: _subtypeInvalid,
            amountInvalid: _amountInvalid,
            titleInvalid: _titleInvalid,
            amount: 111,
          ),
        ],
      );
    });

    group('TransactionChangeDateEvent', () {
      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event',
        build: () => bloc(),
        act: (bloc) => bloc.add(
          TransactionChangeDateEvent(DateTime(1999)),
        ),
        expect: () => [
          TransactionAddEditState(
            date: DateTime(1999),
            subtypeInvalid: _subtypeInvalid,
            titleInvalid: _titleInvalid,
            amountInvalid: _amountInvalid,
          ),
        ],
      );
    });

    group('TransactionSaveEvent', () {
      final updatedStates = [
        TransactionAddEditState(
          date: date,
          titleInvalid: _titleInvalid,
          amountInvalid: _amountInvalid,
          subtype: subtype,
        ),
        TransactionAddEditState(
          date: date,
          amountInvalid: _amountInvalid,
          subtype: subtype,
          title: 'title',
        ),
        TransactionAddEditState(
          date: date,
          subtype: subtype,
          title: 'title',
          amount: 111,
        ),
        TransactionAddEditState(
          date: DateTime(2021),
          subtype: subtype,
          title: 'title',
          amount: 111,
        ),
        TransactionAddEditState(
          date: DateTime(2021),
          subtype: subtype,
          title: 'title',
          amount: 111,
          loading: true,
        ),
      ];

      final successfulState = TransactionAddEditState(
        date: DateTime(2021),
        subtype: subtype,
        title: 'title',
        amount: 111,
        success: true,
      );

      final errorState = TransactionAddEditState(
          date: DateTime(2021),
          subtype: subtype,
          title: 'title',
          amount: 111,
          error: 'Exception: Error');

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event has invalid values',
        build: () => bloc(),
        act: (bloc) => bloc.add(
          TransactionSaveEvent(),
        ),
        expect: () => [
          TransactionAddEditState(
            date: date,
            titleInvalid: _titleInvalid,
            amountInvalid: _amountInvalid,
            subtypeInvalid: _subtypeInvalid,
            error: 'Incorrect value',
          ),
        ],
      );

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event when transaction is added successfully',
        build: () {
          when(_addInteractor(transaction)).thenAnswer((_) async {});
          return bloc();
        },
        act: (bloc) {
          bloc
            ..add(TransactionChooseSubtypeEvent(subtype))
            ..add(TransactionChangeTitleEvent('title'))
            ..add(TransactionChangeAmountEvent('111'))
            ..add(TransactionChangeDateEvent(DateTime(2021)))
            ..add(TransactionSaveEvent());
        },
        expect: () => [
          ...updatedStates,
          successfulState,
        ],
      );

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event when transaction is updated successfully',
        build: () {
          when(_updateInteractor(transaction)).thenAnswer((_) async {});
          return bloc();
        },
        act: (bloc) {
          bloc
            ..add(TransactionChooseSubtypeEvent(subtype))
            ..add(TransactionChangeTitleEvent('title'))
            ..add(TransactionChangeAmountEvent('111'))
            ..add(TransactionChangeDateEvent(DateTime(2021)))
            ..add(TransactionSaveEvent(transaction: transaction));
        },
        expect: () => [
          ...updatedStates,
          successfulState,
        ],
      );

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event when transaction is added badly',
        build: () {
          final currentTransaction = Transaction(
            amountOfMoney: 111,
            subtype: subtype,
            title: 'title',
            dateOfOperation: DateTime(2021),
            dateCreate: date,
          );
          when(_addInteractor(currentTransaction))
              .thenThrow(Exception('Error'));
          return bloc();
        },
        act: (bloc) {
          bloc
            ..add(TransactionChooseSubtypeEvent(subtype))
            ..add(TransactionChangeTitleEvent('title'))
            ..add(TransactionChangeAmountEvent('111'))
            ..add(TransactionChangeDateEvent(DateTime(2021)))
            ..add(TransactionSaveEvent());
        },
        expect: () => [
          ...updatedStates,
          errorState,
        ],
      );

      blocTest<TransactionAddEditBloc, TransactionAddEditState>(
        'state after event when transaction is updated badly',
        build: () {
          final currentTransaction = Transaction(
            amountOfMoney: 111,
            subtype: subtype,
            title: 'title',
            dateOfOperation: DateTime(2021),
            dateCreate: date,
            id: '3',
          );
          when(_updateInteractor(currentTransaction))
              .thenThrow(Exception('Error'));
          return bloc();
        },
        act: (bloc) {
          bloc
            ..add(TransactionChooseSubtypeEvent(subtype))
            ..add(TransactionChangeTitleEvent('title'))
            ..add(TransactionChangeAmountEvent('111'))
            ..add(TransactionChangeDateEvent(DateTime(2021)))
            ..add(TransactionSaveEvent(transaction: transaction));
        },
        expect: () => [
          ...updatedStates,
          errorState,
        ],
      );
    });
  });
}
