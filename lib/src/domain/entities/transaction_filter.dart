import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:equatable/equatable.dart';

class TransactionFilter extends Equatable {
  const TransactionFilter({
    this.maxAmountOfMoney,
    this.maxDateOfOperation,
    this.minAmountOfMoney,
    this.minDateOfOperation,
    this.subtypes,
    this.title,
    this.type,
  });

  final String? title;
  final double? minAmountOfMoney;
  final double? maxAmountOfMoney;
  final DateTime? minDateOfOperation;
  final DateTime? maxDateOfOperation;
  final List<TransactionSubtype>? subtypes;
  final TransactionType? type;

  @override
  List<Object?> get props => [
        title,
        minAmountOfMoney,
        maxAmountOfMoney,
        minDateOfOperation,
        maxDateOfOperation,
        subtypes,
        type,
      ];
}
