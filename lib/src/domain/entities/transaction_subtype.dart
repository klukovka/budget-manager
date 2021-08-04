import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:equatable/equatable.dart';

class TransactionSubtype extends Equatable {
  const TransactionSubtype({
    required this.id,
    required this.name,
    required this.type,
  });

  final String id;
  final String name;
  final TransactionType type;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
      ];
}
