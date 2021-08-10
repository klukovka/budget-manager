import 'package:budget_manager/src/domain/entities/sort_by_parametr.dart';
import 'package:budget_manager/src/domain/entities/sort_order.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';

abstract class TransactionSortEvent {}

class TransactionSortOrderEvent extends TransactionSortEvent {
  TransactionSortOrderEvent(this.order);
  final SortOrder order;
}

class TransactionSortParametrEvent extends TransactionSortEvent {
  TransactionSortParametrEvent(this.parametr);
  final SortByParametr parametr;
}

class TransactionInitialEvent extends TransactionSortEvent {
  TransactionInitialEvent(this.params);
  final TransactionSortParams params;
}

