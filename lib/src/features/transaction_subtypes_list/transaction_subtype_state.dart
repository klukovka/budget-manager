import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionSubtypeState extends Equatable {}

class TransactionSubtypeLoadingState extends TransactionSubtypeState {
  @override
  List<Object?> get props => [];
}

class TransactionSubtypeLoadedState extends TransactionSubtypeState {
  TransactionSubtypeLoadedState(this.subtypes);
  final List<TransactionSubtype> subtypes;

  @override
  List<Object?> get props => [subtypes];
}


class TransactionSubtypeErrorState extends TransactionSubtypeState {
  TransactionSubtypeErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
