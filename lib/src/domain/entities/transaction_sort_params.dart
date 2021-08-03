import 'package:budget_manager/src/domain/entities/sort_by_parametr.dart';
import 'package:budget_manager/src/domain/entities/sort_order.dart';
import 'package:equatable/equatable.dart';

class TransactionSortParams extends Equatable {
  const TransactionSortParams({
    this.order = SortOrder.desc,
    this.parametr = SortByParametr.dateOfOperation,
  });

  final SortOrder order;
  final SortByParametr parametr;

  @override
  List<Object?> get props => [
        order,
        parametr,
      ];
}
