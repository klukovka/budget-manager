import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:equatable/equatable.dart';

class TransactionScreenState extends Equatable {
  const TransactionScreenState({
    this.error,
    this.loading = false,
    this.params,
    this.sum,
    this.transactions,
    this.isVisible = false,
  });

  final TransactionRequestParams? params;
  final bool loading;
  final List<Transaction>? transactions;
  final String? error;
  final double? sum;
  final bool isVisible;

  TransactionScreenState copyWith({
    TransactionRequestParams? params,
    bool? loading,
    List<Transaction>? transactions,
    String? error,
    double? sum,
    bool? isVisible,
  }) {
    return TransactionScreenState(
        error: this.error,
        loading: loading ?? this.loading,
        params: params ?? this.params,
        sum: sum ?? this.sum,
        transactions: transactions ?? this.transactions,
        isVisible: isVisible ?? this.isVisible);
  }

  @override
  List<Object?> get props => [
        loading,
        params,
        sum,
        transactions,
        isVisible,
      ];
}
