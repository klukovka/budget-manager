import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:equatable/equatable.dart';

class TransactionFilterState extends Equatable {
  const TransactionFilterState({
    required this.filter,
    this.maxAmountError,
    this.minAmountError,
    this.dateError,
  });
  final TransactionFilter filter;
  final String? maxAmountError;
  final String? minAmountError;
  final String? dateError;

  TransactionFilterState clearMinAmount(double? minAmount) {
    return TransactionFilterState(
      dateError: dateError,
      maxAmountError: maxAmountError,
      filter: TransactionFilter(
        maxAmountOfMoney: filter.maxAmountOfMoney,
        minAmountOfMoney: minAmount,
        minDateOfOperation: filter.minDateOfOperation,
        maxDateOfOperation: filter.maxDateOfOperation,
        subtypes: filter.subtypes,
        title: filter.title,
        type: filter.type,
      ),
    );
  }

  TransactionFilterState clearMaxAmount(double? maxAmount) {
    return TransactionFilterState(
      dateError: dateError,
      minAmountError: minAmountError,
      filter: TransactionFilter(
        maxAmountOfMoney: maxAmount,
        minAmountOfMoney: filter.minAmountOfMoney,
        minDateOfOperation: filter.minDateOfOperation,
        maxDateOfOperation: filter.maxDateOfOperation,
        subtypes: filter.subtypes,
        title: filter.title,
        type: filter.type,
      ),
    );
  }

  TransactionFilterState clearMinDate(DateTime? minDate) {
    return TransactionFilterState(
      maxAmountError: maxAmountError,
      minAmountError: minAmountError,
      filter: TransactionFilter(
        maxAmountOfMoney: filter.maxAmountOfMoney,
        minAmountOfMoney: filter.minAmountOfMoney,
        minDateOfOperation: minDate,
        maxDateOfOperation: filter.maxDateOfOperation,
        subtypes: filter.subtypes,
        title: filter.title,
        type: filter.type,
      ),
    );
  }

  TransactionFilterState clearMaxDate(DateTime? maxDate) {
    return TransactionFilterState(
      maxAmountError: maxAmountError,
      minAmountError: minAmountError,
      filter: TransactionFilter(
        maxAmountOfMoney: filter.maxAmountOfMoney,
        minAmountOfMoney: filter.minAmountOfMoney,
        minDateOfOperation: filter.minDateOfOperation,
        maxDateOfOperation: maxDate,
        subtypes: filter.subtypes,
        title: filter.title,
        type: filter.type,
      ),
    );
  }

  TransactionFilterState clearSubtypes(List<TransactionSubtype>? subtypes) {
    return copyWith(
      filter: TransactionFilter(
        maxAmountOfMoney: filter.maxAmountOfMoney,
        minAmountOfMoney: filter.minAmountOfMoney,
        minDateOfOperation: filter.minDateOfOperation,
        maxDateOfOperation: filter.maxDateOfOperation,
        subtypes: subtypes,
        title: filter.title,
        type: filter.type,
      ),
    );
  }

  TransactionFilterState copyWith(
      {TransactionFilter? filter,
      String? maxAmountError,
      String? minAmountError,
      String? dateError}) {
    return TransactionFilterState(
      filter: filter ?? this.filter,
      maxAmountError: maxAmountError ?? this.maxAmountError,
      minAmountError: minAmountError ?? this.minAmountError,
      dateError: dateError ?? this.dateError,
    );
  }

  @override
  List<Object?> get props => [
        filter,
        maxAmountError,
        minAmountError,
        dateError,
      ];
}
