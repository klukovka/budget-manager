import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:equatable/equatable.dart';

class TransactionRequestParams extends Equatable {
  const TransactionRequestParams({
    required this.filter,
    required this.sort,
  });

  final TransactionFilter filter;
  final TransactionSortParams sort;

  @override
  List<Object?> get props => [
        filter,
        sort,
      ];
}
