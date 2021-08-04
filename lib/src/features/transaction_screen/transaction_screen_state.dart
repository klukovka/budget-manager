import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:equatable/equatable.dart';

class TransactionScreenState extends Equatable {
  const TransactionScreenState({
    required this.params,
    this.error,
    this.loading = true,
    this.sum,
    this.transactions,
    this.isVisibleSearchField = false,
    this.isVisibleContextMenu = false,
  });

  final TransactionRequestParams params;
  final bool loading;
  final List<Transaction>? transactions;
  final String? error;
  final double? sum;
  final bool isVisibleSearchField;
  final bool isVisibleContextMenu;

  TransactionScreenState copyWith({
    TransactionRequestParams? params,
    bool? loading,
    List<Transaction>? transactions,
    String? error,
    double? sum,
    bool? isVisibleSearchField,
    bool? isVisibleContextMenu,
  }) {
    return TransactionScreenState(
        error: this.error,
        loading: loading ?? this.loading,
        params: params ?? this.params,
        sum: sum ?? this.sum,
        transactions: transactions ?? this.transactions,
        isVisibleSearchField: isVisibleSearchField ?? this.isVisibleSearchField,
        isVisibleContextMenu:
            isVisibleContextMenu ?? this.isVisibleContextMenu);
  }

  @override
  List<Object?> get props => [
        loading,
        params,
        sum,
        transactions,
        isVisibleSearchField,
        isVisibleContextMenu,
      ];


}
