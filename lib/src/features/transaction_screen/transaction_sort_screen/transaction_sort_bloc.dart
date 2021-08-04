import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_sort_screen/transaction_sort_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionSortBloc
    extends Bloc<TransactionSortEvent, TransactionSortParams> {
  TransactionSortBloc() : super(const TransactionSortParams());

  @override
  Stream<TransactionSortParams> mapEventToState(
      TransactionSortEvent event) async* {
    if (event is TransactionSortOrderEvent) {
      yield TransactionSortParams(order: event.order, parametr: state.parametr);

    } else if (event is TransactionSortParametrEvent) {
      yield TransactionSortParams(order: state.order, parametr: event.parametr);

    } else if (event is TransactionInitialEvent) {
      yield event.params;
    }
  }
}
