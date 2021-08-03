import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.amountOfMoney,
    required this.dateCreate,
    required this.dateOfOperation,
    required this.subtype,
    required this.title,
    this.id,
  });

  final String? id;
  final String title;
  final double amountOfMoney;
  final DateTime dateOfOperation;
  final DateTime dateCreate;
  final TransactionSubtype subtype;

  @override
  List<Object?> get props => [
        id,
        title,
        amountOfMoney,
        dateOfOperation,
        dateCreate,
        subtype,
      ];
}
