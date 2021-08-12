import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_event.dart';
import 'package:test/test.dart';

void main() {
  group('TransactionAddEditEvent', () {
    const subtype = TransactionSubtype(
      id: '1',
      name: 'Education',
      type: TransactionType.costs,
    );

    group('TransactionSaveEvent', () {
      test('supports value comparison', () {
        final transaction = Transaction(
          amountOfMoney: 10,
          dateCreate: DateTime(2021),
          dateOfOperation: DateTime(2021),
          subtype: subtype,
          title: 'Title',
        );
        expect(
          TransactionSaveEvent(
            transaction: transaction,
          ),
          TransactionSaveEvent(
            transaction: transaction,
          ),
        );
      });
    });

    group('TransactionChooseSubtypeEvent', () {
      test('supports value comparison', () {
        expect(
          TransactionChooseSubtypeEvent(subtype),
          TransactionChooseSubtypeEvent(subtype),
        );
      });
    });

    group('TransactionChangeTitleEvent', () {
      test('supports value comparison', () {
        expect(
          TransactionChangeTitleEvent('title'),
          TransactionChangeTitleEvent('title'),
        );
      });
    });

    group('TransactionChangeMoneyEvent', () {
      test('supports value comparison', () {
        expect(
          TransactionChangeAmountEvent('111'),
          TransactionChangeAmountEvent('111'),
        );
      });
    });

    group('TransactionChangeDateEvent', () {
      test('supports value comparison', () {
        expect(
          TransactionChangeDateEvent(DateTime(2021)),
          TransactionChangeDateEvent(DateTime(2021)),
        );
      });
    });
  });
}
