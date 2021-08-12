import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/interactors/add_transaction_interactor.dart';
import 'package:budget_manager/src/domain/interactors/update_transaction_interactor.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_event.dart';
import 'package:budget_manager/src/features/transaction_add_edit_screen/transaction_add_edit_state.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _titleInvalid = LocaleKeys.invalidTitle.tr();
final _amountInvalid = LocaleKeys.invalidMoney.tr();
final _subtypeInvalid = LocaleKeys.invalidSubtype.tr();

class TransactionAddEditBloc
    extends Bloc<TransactionAddEditEvent, TransactionAddEditState> {
  TransactionAddEditBloc(
    this._addInteractor,
    this._updateInteractor,
  ) : super(
          TransactionAddEditState(
            date: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
            titleInvalid: _titleInvalid,
            amountInvalid: _amountInvalid,
            subtypeInvalid: _subtypeInvalid,
          ),
        );

  final AddTransactionInteractor _addInteractor;
  final UpdateTransactionInteractor _updateInteractor;

  @override
  Stream<TransactionAddEditState> mapEventToState(
      TransactionAddEditEvent event) async* {
    if (event is TransactionChooseSubtypeEvent) {
      yield state.clearInvalidAssignSubtype(event.subtype);

    } else if (event is TransactionChangeTitleEvent) {
      yield* _changeTitle(event);

    } else if (event is TransactionChangeAmountEvent) {
      yield* _changeAmount(event);

    } else if (event is TransactionChangeDateEvent) {
      yield state.copyWith(date: event.date);

    } else if (event is TransactionSaveEvent) {
      yield* _saveTransaction(event);
    }
  }

  Stream<TransactionAddEditState> _changeTitle(
      TransactionChangeTitleEvent event) async* {
    if (event.title == null || event.title!.length < 3) {
      yield state.copyWith(titleInvalid: _titleInvalid);
    } else {
      yield state.clearInvalidAssignTitle(event.title!);
    }
  }

  Stream<TransactionAddEditState> _changeAmount(
      TransactionChangeAmountEvent event) async* {
    try {
      final amount = double.parse(event.amount!);

      yield state.clearInvalidAssignAmount(amount);
    } on Exception {
      yield state.copyWith(amountInvalid: _amountInvalid);
    }
  }

  Stream<TransactionAddEditState> _saveTransaction(
      TransactionSaveEvent event) async* {
    try {
      if (state.amountInvalid != null ||
          state.titleInvalid != null ||
          state.subtypeInvalid != null) {
        yield state.copyWith(error: LocaleKeys.error.tr());
        
      } else {
        yield state.copyWith(loading: true);

        final transaction = Transaction(
          amountOfMoney: state.amount!,
          dateCreate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          dateOfOperation: state.date,
          subtype: state.subtype!,
          title: state.title!,
          id: event.transaction != null ? event.transaction!.id : null,
        );

        if (event.transaction != null) {
          await _updateInteractor(transaction);
        } else {
          await _addInteractor(transaction);
        }
        yield state.copyWith(success: true, loading: false);
      }
    } on Exception catch (error) {
      yield state.copyWith(error: '$error', loading: false);
    }
  }
}
