import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionAddEditEvent extends Equatable {}

class TransactionSaveEvent extends TransactionAddEditEvent {
  TransactionSaveEvent({
    this.transaction,
  });

  final Transaction? transaction;

  @override
  List<Object?> get props => [
        transaction,
      ];
}

class TransactionChooseSubtypeEvent extends TransactionAddEditEvent {
  TransactionChooseSubtypeEvent(this.subtype);

  final TransactionSubtype subtype;

  @override
  List<Object?> get props => [subtype];
}

class TransactionChangeTitleEvent extends TransactionAddEditEvent {
  TransactionChangeTitleEvent(this.title);

  final String? title;

  @override
  List<Object?> get props => [title];
}

class TransactionChangeAmountEvent extends TransactionAddEditEvent {
  TransactionChangeAmountEvent(this.amount);

  final String? amount;

  @override
  List<Object?> get props => [amount];
}

class TransactionChangeDateEvent extends TransactionAddEditEvent {
  TransactionChangeDateEvent(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}