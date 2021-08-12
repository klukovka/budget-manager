import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_state.dart';
import 'package:test/test.dart';

void main() {
  group('TransactionAddEditState', () {
    const subtype = TransactionSubtype(
      id: '1',
      name: 'name',
      type: TransactionType.costs,
    );

    final state = TransactionAddEditState(
      error: 'error',
      amountInvalid: 'amountInvalid',
      subtype: subtype,
      subtypeInvalid: 'subtypeInvalid',
      titleInvalid: 'titleInvalid',
      date: DateTime(2020),
      title: 'title',
      amount: 100,
    );

    group('supports value comparison with', () {
      test('error', () {
        expect(
          TransactionAddEditState(
            error: 'error',
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            error: 'error',
            date: DateTime(2020),
          ),
        );
      });
      test('amountInvalid', () {
        expect(
          TransactionAddEditState(
            amountInvalid: 'amountInvalid',
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            amountInvalid: 'amountInvalid',
            date: DateTime(2020),
          ),
        );
      });
      test('subtype', () {
        expect(
          TransactionAddEditState(
            subtype: subtype,
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            subtype: subtype,
            date: DateTime(2020),
          ),
        );
      });
      test('subtypeInvalid', () {
        expect(
          TransactionAddEditState(
            subtypeInvalid: 'subtypeInvalid',
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            subtypeInvalid: 'subtypeInvalid',
            date: DateTime(2020),
          ),
        );
      });
      test('success', () {
        expect(
          TransactionAddEditState(
            success: true,
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            success: true,
            date: DateTime(2020),
          ),
        );
      });
      test('loading', () {
        expect(
          TransactionAddEditState(
            loading: true,
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            loading: true,
            date: DateTime(2020),
          ),
        );
      });
      test('titleInvalid', () {
        expect(
          TransactionAddEditState(
            titleInvalid: 'titleInvalid',
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            titleInvalid: 'titleInvalid',
            date: DateTime(2020),
          ),
        );
      });

      test('title', () {
        expect(
          TransactionAddEditState(
            title: 'title',
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            title: 'title',
            date: DateTime(2020),
          ),
        );
      });

      test('amount', () {
        expect(
          TransactionAddEditState(
            amount: 100,
            date: DateTime(2020),
          ),
          TransactionAddEditState(
            amount: 100,
            date: DateTime(2020),
          ),
        );
      });

      test('date', () {
        expect(
          TransactionAddEditState(date: DateTime(2020)),
          TransactionAddEditState(date: DateTime(2020)),
        );
      });
    });

    group('supports copy method with', () {
      test('error', () {
        final currentState = TransactionAddEditState(
          error: 'new error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(state.copyWith(error: 'new error'), currentState);
      });

      test('amountInvalid', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'new amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(
          state.copyWith(amountInvalid: 'new amountInvalid'),
          currentState,
        );
      });

      test('subtype', () {
        const currentSubtype = TransactionSubtype(
          id: '2',
          name: 'Education',
          type: TransactionType.revenue,
        );

        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: currentSubtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(
          state.copyWith(subtype: currentSubtype),
          currentState,
        );
      });

      test('subtypeInvalid', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'new subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(
          state.copyWith(subtypeInvalid: 'new subtypeInvalid'),
          currentState,
        );
      });

      test('titleInvalid', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'new titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(
          state.copyWith(titleInvalid: 'new titleInvalid'),
          currentState,
        );
      });

      test('date', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(1990),
          title: 'title',
          amount: 100,
        );

        expect(
          state.copyWith(date: DateTime(1990)),
          currentState,
        );
      });

      test('title', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'new title',
          amount: 100,
        );

        expect(
          state.copyWith(title: 'new title'),
          currentState,
        );
      });

      test('amount', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 200,
        );

        expect(
          state.copyWith(amount: 200),
          currentState,
        );
      });

      test('success', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          success: true,
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(state.copyWith(success: true), currentState);
      });

      test('loading', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          loading: true,
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(state.copyWith(loading: true), currentState);
      });
    });

    group('supports clear an invalid sign and assigns a valid value: ', () {
      test('clear titleInvalid and assign title', () {
        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          date: DateTime(2020),
          title: 'new title',
          amount: 100,
        );

        expect(state.clearInvalidAssignTitle('new title'), currentState);
      });

      test('clear amountInvalid and assign amount', () {
        final currentState = TransactionAddEditState(
          titleInvalid: 'titleInvalid',
          error: 'error',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 200,
        );

        expect(state.clearInvalidAssignAmount(200), currentState);
      });

      test('clear subtypeInvalid and assign subtype', () {
        const currentSubtype = TransactionSubtype(
          id: '3',
          name: 'Salary',
          type: TransactionType.revenue,
        );

        final currentState = TransactionAddEditState(
          error: 'error',
          amountInvalid: 'amountInvalid',
          subtype: currentSubtype,
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(state.clearInvalidAssignSubtype(currentSubtype), currentState);
      });

      test('clear error', () {
        final currentState = TransactionAddEditState(
          amountInvalid: 'amountInvalid',
          subtype: subtype,
          subtypeInvalid: 'subtypeInvalid',
          titleInvalid: 'titleInvalid',
          date: DateTime(2020),
          title: 'title',
          amount: 100,
        );

        expect(state.clearError(), currentState);
      });
    });
  });
}
