import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';

abstract class TransactionScreenEvent {}

class SearchFieldEvent extends TransactionScreenEvent {
  SearchFieldEvent({required this.visible});

  final bool visible;
}

class TransactionScreenParamsEvent extends TransactionScreenEvent {
  TransactionScreenParamsEvent(this.params);

  final TransactionRequestParams params;
}

class TransactionRemoveEvent extends TransactionScreenEvent {
  TransactionRemoveEvent(this.transaction);

  final Transaction transaction;
}

class TransactionScreenReloadEvent extends TransactionScreenEvent {}
