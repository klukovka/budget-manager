import 'package:budget_manager/src/domain/entities/sort_by_parametr.dart';
import 'package:budget_manager/src/domain/entities/sort_order.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/repositories/transaction_repository.dart';

class MockTransactionRepositoryImpl implements TransactionRepository {
  List<Transaction> transactions = [
    Transaction(
        id: '1',
        amountOfMoney: 100,
        dateCreate: DateTime(2021, 7, 12),
        dateOfOperation: DateTime(2021, 7, 12),
        subtype: const TransactionSubtype(
          id: '1',
          name: 'Transport',
          type: TransactionType.costs,
        ),
        title: 'title1'),
    Transaction(
        id: '2',
        amountOfMoney: 200,
        dateCreate: DateTime(2021, 7, 14),
        dateOfOperation: DateTime(2021, 7, 14),
        subtype: const TransactionSubtype(
          id: '2',
          name: 'Shopping',
          type: TransactionType.costs,
        ),
        title: 'title2'),
    Transaction(
        id: '3',
        amountOfMoney: 30,
        dateCreate: DateTime(2021, 7, 18),
        dateOfOperation: DateTime(2021, 7, 14),
        subtype: const TransactionSubtype(
          id: '3',
          name: 'Education',
          type: TransactionType.costs,
        ),
        title: 'title3'),
    Transaction(
        id: '4',
        amountOfMoney: 2000,
        dateCreate: DateTime(2021, 7, 19),
        dateOfOperation: DateTime(2021, 7, 19),
        subtype: const TransactionSubtype(
          id: '4',
          name: 'Hobby',
          type: TransactionType.costs,
        ),
        title: 'title4'),
    Transaction(
        id: '5',
        amountOfMoney: 20000,
        dateCreate: DateTime(2021, 7, 21),
        dateOfOperation: DateTime(2021, 7, 21),
        subtype: const TransactionSubtype(
          id: '5',
          name: 'Salary',
          type: TransactionType.revenue,
        ),
        title: 'title5'),
    Transaction(
        id: '6',
        amountOfMoney: 900,
        dateCreate: DateTime(2021, 7, 22),
        dateOfOperation: DateTime(2021, 7, 21),
        subtype: const TransactionSubtype(
          id: '6',
          name: 'Gift',
          type: TransactionType.revenue,
        ),
        title: 'title6'),
    Transaction(
        id: '7',
        amountOfMoney: 1200,
        dateCreate: DateTime(2021, 8),
        dateOfOperation: DateTime(2021, 8),
        subtype: const TransactionSubtype(
          id: '7',
          name: 'Part-time job',
          type: TransactionType.revenue,
        ),
        title: 'title7'),
    Transaction(
        id: '8',
        amountOfMoney: 120,
        dateCreate: DateTime(2021, 8),
        dateOfOperation: DateTime(2021, 8),
        subtype: const TransactionSubtype(
          id: '1',
          name: 'Part-time job',
          type: TransactionType.costs,
        ),
        title: 'title8'),
    Transaction(
        id: '9',
        amountOfMoney: 90,
        dateCreate: DateTime(2021, 8, 2),
        dateOfOperation: DateTime(2021, 8),
        subtype: const TransactionSubtype(
          id: '2',
          name: 'Shopping',
          type: TransactionType.costs,
        ),
        title: 'title9'),
    Transaction(
        id: '10',
        amountOfMoney: 120.5,
        dateCreate: DateTime(2021, 8, 3),
        dateOfOperation: DateTime(2021, 8, 3),
        subtype: const TransactionSubtype(
          id: '3',
          name: 'Education',
          type: TransactionType.costs,
        ),
        title: 'title10'),
    Transaction(
        id: '11',
        amountOfMoney: 10,
        dateCreate: DateTime(2021, 8, 3),
        dateOfOperation: DateTime(2021, 8, 3),
        subtype: const TransactionSubtype(
          id: '4',
          name: 'Hobby',
          type: TransactionType.costs,
        ),
        title: 'title11'),
  ];

  @override
  Future<void> add(Transaction transaction) {
    // TODO(klukovka): implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getWithRequestParams(
      TransactionRequestParams requestParams) async {
    var resultTransactions = await getWithFilter(requestParams.filter)
      ..sort((current, next) => current.dateCreate.compareTo(next.dateCreate));

    switch (requestParams.sort.order) {
      case SortOrder.asc:
        switch (requestParams.sort.parametr) {
          case SortByParametr.amountOfMoney:
            resultTransactions.sort((current, next) =>
                current.amountOfMoney.compareTo(next.amountOfMoney));
            break;
          case SortByParametr.dateOfOperation:
            resultTransactions.sort((current, next) =>
                current.dateOfOperation.compareTo(next.dateOfOperation));
            break;
          case SortByParametr.subtype:
            resultTransactions.sort((current, next) =>
                current.subtype.name.compareTo(next.subtype.name));
            break;
          case SortByParametr.title:
            resultTransactions
                .sort((current, next) => current.title.compareTo(next.title));
            break;
          default:
            break;
        }
        break;
      case SortOrder.desc:
        switch (requestParams.sort.parametr) {
          case SortByParametr.amountOfMoney:
            resultTransactions.sort((current, next) =>
                next.amountOfMoney.compareTo(current.amountOfMoney));
            break;
          case SortByParametr.dateOfOperation:
            resultTransactions.sort((current, next) =>
                next.dateOfOperation.compareTo(current.dateOfOperation));
            break;
          case SortByParametr.subtype:
            resultTransactions.sort((current, next) =>
                next.subtype.name.compareTo(current.subtype.name));
            break;
          case SortByParametr.title:
            resultTransactions
                .sort((current, next) => next.title.compareTo(current.title));
            break;
          default:
            break;
        }
        break;
      default:
        break;
    }

    return resultTransactions;
  }

  @override
  Future<List<Transaction>> getWithFilter(TransactionFilter filter) async {
    return transactions.where((transaction) {
      return _filterByTitle(filter.title, transaction) &&
          _filterByMinAmountOfMoney(filter.minAmountOfMoney, transaction) &&
          _filterByMinDateOfOperation(filter.minDateOfOperation, transaction) &&
          _filterByMaxAmountOfMoney(filter.maxAmountOfMoney, transaction) &&
          _filterByMaxDateOfOperation(filter.maxDateOfOperation, transaction) &&
          _filterBySubtypes(filter.subtypes, transaction) &&
          _filterByType(filter.type, transaction);
    }).toList();
  }

  bool _filterByTitle(String? title, Transaction transaction) {
    if (title != null) {
      return transaction.title.contains(title);
    } else {
      return true;
    }
  }

  bool _filterByMinAmountOfMoney(
      double? minAmountOfMoney, Transaction transaction) {
    if (minAmountOfMoney != null) {
      return transaction.amountOfMoney >= minAmountOfMoney;
    } else {
      return true;
    }
  }

  bool _filterByMaxAmountOfMoney(
      double? maxAmountOfMoney, Transaction transaction) {
    if (maxAmountOfMoney != null) {
      return transaction.amountOfMoney <= maxAmountOfMoney;
    } else {
      return true;
    }
  }

  bool _filterByMinDateOfOperation(
      DateTime? minDateOfOperation, Transaction transaction) {
    if (minDateOfOperation != null) {
      return minDateOfOperation.isBefore(
          transaction.dateOfOperation.subtract(const Duration(days: 1)));
    } else {
      return true;
    }
  }

  bool _filterByMaxDateOfOperation(
      DateTime? maxDateOfOperation, Transaction transaction) {
    if (maxDateOfOperation != null) {
      return maxDateOfOperation
          .isAfter(transaction.dateOfOperation.add(const Duration(days: 1)));
    } else {
      return true;
    }
  }

  bool _filterBySubtypes(
      List<TransactionSubtype>? subtypes, Transaction transaction) {
    if (subtypes != null && subtypes.isNotEmpty) {
      return subtypes.contains(transaction.subtype);
    } else {
      return true;
    }
  }

  bool _filterByType(TransactionType? type, Transaction transaction) {
    if (type != null) {
      return transaction.subtype.type == type;
    } else {
      return true;
    }
  }

  @override
  Future<void> remove(Transaction transaction) async {
    transactions.remove(transaction);
  }

  @override
  Future<void> update(Transaction transaction) {
    // TODO(klukovka): implement update
    throw UnimplementedError();
  }
}
