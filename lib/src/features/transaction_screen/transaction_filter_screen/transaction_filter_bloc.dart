import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_state.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFilterBloc
    extends Bloc<TransactionFilterEvent, TransactionFilterState> {
  TransactionFilterBloc()
      : super(
          const TransactionFilterState(
            filter: TransactionFilter(),
          ),
        );

  @override
  Stream<TransactionFilterState> mapEventToState(
      TransactionFilterEvent event) async* {
    if (event is ChooseMinAmountEvent) {
      yield* _processMinAmount(event);

    } else if (event is ChooseMaxAmountEvent) {
      yield* _processMaxAmount(event);

    } else if (event is ChooseMinDateEvent) {
      yield* _processMinDate(event);

    } else if (event is ChooseMaxDateEvent) {
      yield* _processMaxDate(event);

    } else if (event is ChooseSubtypesEvent) {
      yield state.clearSubtypes(event.subtypes);

    } else if (event is GetInitialState) {
      yield state.copyWith(filter: event.filter);
    }

  }

  Stream<TransactionFilterState> _processMinAmount(
      ChooseMinAmountEvent event) async* {
    try {
      final minAmount = _mapStringToDouble(event.minAmountOfMoney);

      if (minAmount != null &&
          state.filter.maxAmountOfMoney != null &&
          minAmount > state.filter.maxAmountOfMoney!) {
        yield state.copyWith(
            minAmountError: LocaleKeys.moneyLess.tr());
      } else {
        yield state.clearMinAmount(minAmount);
      }
    } on Exception catch (error) {
      yield state.copyWith(minAmountError: '$error');
    }
  }

  Stream<TransactionFilterState> _processMaxAmount(
      ChooseMaxAmountEvent event) async* {
    try {
      final maxAmount = _mapStringToDouble(event.maxAmountOfMoney);

      if (maxAmount != null &&
          state.filter.minAmountOfMoney != null &&
          maxAmount < state.filter.minAmountOfMoney!) {
        yield state.copyWith(
            maxAmountError: LocaleKeys.moneyBigger.tr());
      } else {
        yield state.clearMaxAmount(maxAmount);
      }
    } on Exception catch (error) {
      yield state.copyWith(maxAmountError: '$error');
    }
  }

  double? _mapStringToDouble([String? amountString]) {
    final double? amount;

    if (amountString != null && amountString.isNotEmpty) {
      amount = double.parse(amountString);
    } else {
      amount = null;
    }
    return amount;
  }

  Stream<TransactionFilterState> _processMinDate(
      ChooseMinDateEvent event) async* {
    final minDate = event.minDate;

    if (minDate != null &&
        state.filter.minDateOfOperation != null &&
        minDate.isAfter(state.filter.maxDateOfOperation!)) {
      yield state.copyWith(
          dateError: LocaleKeys.dateLess.tr());
    } else {
      yield state.clearMinDate(minDate);
    }
  }

  Stream<TransactionFilterState> _processMaxDate(
      ChooseMaxDateEvent event) async* {
    final maxDate = event.maxDate;

    if (maxDate != null &&
        state.filter.maxDateOfOperation != null &&
        maxDate.isBefore(state.filter.minDateOfOperation!)) {
      yield state.copyWith(
          dateError: LocaleKeys.dateBigger.tr());
    } else {
      yield state.clearMaxDate(maxDate);
    }
  }
}
