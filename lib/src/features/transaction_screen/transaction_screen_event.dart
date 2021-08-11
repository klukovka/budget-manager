import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionScreenEvent extends Equatable {}

class SearchFieldEvent extends TransactionScreenEvent {
  SearchFieldEvent({required this.visible});

  final bool visible;

  @override
  List<Object?> get props => [visible];
}

class ContextMenuEvent extends TransactionScreenEvent {
  ContextMenuEvent({required this.visible});

  final bool visible;

  @override
  List<Object?> get props => [visible];
}

class TransactionScreenParamsEvent extends TransactionScreenEvent {
  TransactionScreenParamsEvent(this.params);

  final TransactionRequestParams params;

  @override
  List<Object?> get props => [params];
}

class TransactionRemoveEvent extends TransactionScreenEvent {
  TransactionRemoveEvent(this.transaction);

  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}

class TransactionScreenReloadEvent extends TransactionScreenEvent {
  @override
  List<Object?> get props => [];
}
