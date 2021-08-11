import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:equatable/equatable.dart';

class TransactionAddEditState extends Equatable {
  const TransactionAddEditState({
    required this.date,
    this.error,
    this.amountInvalid,
    this.subtype,
    this.subtypeInvalid,
    this.success = false,
    this.titleInvalid,
    this.amount,
    this.title,
    this.loading = false,
  });

  final TransactionSubtype? subtype;
  final String? title;
  final double? amount;
  final DateTime date;
  final String? titleInvalid;
  final String? amountInvalid;
  final String? subtypeInvalid;
  final String? error;
  final bool success;
  final bool loading;

  @override
  List<Object?> get props => [
        subtype,
        titleInvalid,
        amountInvalid,
        subtypeInvalid,
        error,
        success,
        title,
        amount,
        date,
        loading,
      ];

  TransactionAddEditState copyWith({
    TransactionSubtype? subtype,
    String? titleInvalid,
    String? amountInvalid,
    String? subtypeInvalid,
    String? error,
    bool? success,
    String? title,
    double? amount,
    DateTime? date,
    bool? loading,
  }) {
    return TransactionAddEditState(
      subtype: subtype ?? this.subtype,
      titleInvalid: titleInvalid ?? this.titleInvalid,
      amountInvalid: amountInvalid ?? this.amountInvalid,
      subtypeInvalid: subtypeInvalid ?? this.subtypeInvalid,
      error: error ?? this.error,
      success: success ?? this.success,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      loading: loading ?? this.loading,
    );
  }

  TransactionAddEditState clearInvalidAssignTitle(String newTitle) {
    return TransactionAddEditState(
      subtype: subtype,
      amountInvalid: amountInvalid,
      subtypeInvalid: subtypeInvalid,
      error: error,
      success: success,
      amount: amount,
      title: newTitle,
      date: date,
      loading: loading,
    );
  }

  TransactionAddEditState clearInvalidAssignAmount(double newAmount) {
    return TransactionAddEditState(
      subtype: subtype,
      titleInvalid: titleInvalid,
      subtypeInvalid: subtypeInvalid,
      error: error,
      success: success,
      title: title,
      amount: newAmount,
      date: date,
      loading: loading,
    );
  }

  TransactionAddEditState clearInvalidAssignSubtype(
    TransactionSubtype newSubtype,
  ) {
    return TransactionAddEditState(
      subtype: newSubtype,
      titleInvalid: titleInvalid,
      amountInvalid: amountInvalid,
      error: error,
      success: success,
      title: title,
      amount: amount,
      date: date,
      loading: loading,
    );
  }

  TransactionAddEditState clearError() {
    return TransactionAddEditState(
      subtype: subtype,
      titleInvalid: titleInvalid,
      amountInvalid: amountInvalid,
      subtypeInvalid: subtypeInvalid,
      success: success,
      title: title,
      amount: amount,
      date: date,
      loading: loading,
    );
  }
}
