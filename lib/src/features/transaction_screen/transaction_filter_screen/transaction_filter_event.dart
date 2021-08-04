import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';

abstract class TransactionFilterEvent {}

class ChooseMinAmountEvent extends TransactionFilterEvent {
  ChooseMinAmountEvent(this.minAmountOfMoney);
  final String? minAmountOfMoney;
}

class ChooseMaxAmountEvent extends TransactionFilterEvent {
  ChooseMaxAmountEvent(this.maxAmountOfMoney);
  final String? maxAmountOfMoney;
}

class ChooseMinDateEvent extends TransactionFilterEvent {
  ChooseMinDateEvent(this.minDate);
  final DateTime? minDate;
}

class ChooseMaxDateEvent extends TransactionFilterEvent {
  ChooseMaxDateEvent(this.maxDate);
  final DateTime? maxDate;
}

class ChooseSubtypesEvent extends TransactionFilterEvent {
  ChooseSubtypesEvent(this.subtypes);
  final List<TransactionSubtype>? subtypes;
}

class GetInitialState extends TransactionFilterEvent {
  GetInitialState(this.filter);
  final TransactionFilter filter;
}
