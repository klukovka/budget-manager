import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_event.dart';
import 'package:test/test.dart';

void main() {
  group('TransactionScreenEvent', () {
    group('SearchFieldEvent', () {
      test('supports value comparison', () {
        expect(
          SearchFieldEvent(visible: true),
          SearchFieldEvent(visible: true),
        );
      });
    });

    group('ContextMenuEvent', () {
      test('supports value comparison', () {
        expect(
          ContextMenuEvent(visible: false),
          ContextMenuEvent(visible: false),
        );
      });
    });

    group('TransactionScreenParamsEvent', () {
      test('supports value comparison', () {
        const params = TransactionRequestParams(
          filter: TransactionFilter(),
          sort: TransactionSortParams(),
        );
        expect(
          TransactionScreenParamsEvent(params),
          TransactionScreenParamsEvent(params),
        );
      });
    });

    group('TransactionRemoveEvent', () {
      test('supports value comparison', () {
        final transaction = Transaction(
            amountOfMoney: 100,
            dateCreate: DateTime(2021),
            dateOfOperation: DateTime(2021),
            subtype: const TransactionSubtype(
              id: '1',
              name: 'Education',
              type: TransactionType.costs,
            ),
            title: 'Title');
        expect(
          TransactionRemoveEvent(transaction),
          TransactionRemoveEvent(transaction),
        );
      });
    });

    group('TransactionScreenReloadEvent', () {
      test('supports value comparison', () {
        expect(
          TransactionScreenReloadEvent(),
          TransactionScreenReloadEvent(),
        );
      });
    });
  });
}
