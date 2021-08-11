import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_state.dart';
import 'package:test/test.dart';

void main() {
  const params = TransactionRequestParams(
    filter: TransactionFilter(),
    sort: TransactionSortParams(),
  );

  group('TransactionScreenState', () {
    group('Initial state', () {
      test('supports value comparison', () {
        expect(
          const TransactionScreenState(params: params),
          const TransactionScreenState(params: params),
        );
      });
    });

    group('Loading state', () {
      test('supports value comparison', () {
        const loading = false;
        expect(
          const TransactionScreenState(params: params, loading: loading),
          const TransactionScreenState(params: params, loading: loading),
        );
      });
    });

    group('IsVisibleSearchField state', () {
      test('supports value comparison', () {
        const isVisibleSearchField = true;
        expect(
          const TransactionScreenState(
            params: params,
            isVisibleSearchField: isVisibleSearchField,
          ),
          const TransactionScreenState(
            params: params,
            isVisibleSearchField: isVisibleSearchField,
          ),
        );
      });
    });

    group('IsVisibleContextMenu state', () {
      test('supports value comparison', () {
        const isVisibleContextMenu = true;
        expect(
          const TransactionScreenState(
            params: params,
            isVisibleContextMenu: isVisibleContextMenu,
          ),
          const TransactionScreenState(
            params: params,
            isVisibleContextMenu: isVisibleContextMenu,
          ),
        );
      });
    });

    group('Error state', () {
      test('supports value comparison', () {
        expect(
          const TransactionScreenState(params: params, error: 'Exception'),
          const TransactionScreenState(params: params, error: 'Exception'),
        );
      });
    });

    group('Sum state', () {
      test('supports value comparison', () {
        expect(
          const TransactionScreenState(params: params, sum: 100),
          const TransactionScreenState(params: params, sum: 100),
        );
      });
    });

    group('Transactions state', () {
      test('supports value comparison', () {
        final transactions = [
          Transaction(
              amountOfMoney: 100,
              dateCreate: DateTime(2021),
              dateOfOperation: DateTime(2021),
              subtype: const TransactionSubtype(
                id: '1',
                name: 'Education',
                type: TransactionType.costs,
              ),
              title: 'Title'),
        ];
        expect(
          TransactionScreenState(params: params, transactions: transactions),
          TransactionScreenState(params: params, transactions: transactions),
        );
      });
    });
  });
}
