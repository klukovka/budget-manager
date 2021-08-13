import 'package:budget_manager/src/data/repositories/mock_transaction_subtype_repository_impl.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_subtype_by_type_interactor.dart';
import 'package:budget_manager/src/features/base/base_bloc_widget.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/budget_manager_progress_bar.dart';
import 'package:budget_manager/src/features/transaction_subtypes_list/transaction_subtype_bloc.dart';
import 'package:budget_manager/src/features/transaction_subtypes_list/transaction_subtype_state.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:budget_manager/src/features/utils/mappers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class TransactionSubtypeChips extends BaseBlocWidget<TransactionSubtypeBloc,
    TransactionSubtypeState, TransactionType?> {
  const TransactionSubtypeChips(
    this.type,
    this.subtypes,
    this.onSaveSubtypes,
    this.title, {
    Key? key,
  }) : super(key: key);

  final TransactionType? type;
  final List<TransactionSubtype> subtypes;
  final void Function(List<TransactionSubtype>) onSaveSubtypes;
  final Widget title;

  @override
  TransactionSubtypeBloc createBloc(BuildContext context) {
    return TransactionSubtypeBloc(GetTransactionSubtypeByTypeInteractor(
        MockTransactionSubtypeRepositoryImpl()));
  }

  @override
  void onBlocCreate(TransactionSubtypeBloc bloc) {
    bloc.add(type);
  }

  @override
  Widget createChild(BuildContext context) {
    return observe(builder: (context, state) {
      if (state is TransactionSubtypeLoadedState) {
        return MultiSelectFormField(
          title: title,
          fillColor: Theme.of(context).accentColor,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
          validator: (value) {
            if (value == null || value.length == 0) {
              return LocaleKeys.chooseType.tr();
            }
          },
          chipBackGroundColor: Theme.of(context).backgroundColor,
          chipLabelStyle: Theme.of(context).textTheme.bodyText1,
          dialogTextStyle: Theme.of(context).textTheme.bodyText1!,
          checkBoxActiveColor: Theme.of(context).accentColor,
          checkBoxCheckColor: Theme.of(context).focusColor,
          dialogShapeBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          dataSource: mapSubtypeListToMap(state.subtypes),
          textField: 'display',
          valueField: 'value',
          okButtonLabel: LocaleKeys.save.tr(),
          cancelButtonLabel: LocaleKeys.cancel.tr(),
          hintWidget: Text(LocaleKeys.chooseType.tr()),
          initialValue: subtypes,
          onSaved: (value) {
            if (value is List<dynamic>) {
              onSaveSubtypes(mapListDynamicToListSubtype(value));
            }
          },
        );
      }

      if (state is TransactionSubtypeErrorState) {
        return Text(state.error);
      }
      return const BudgetManagerProgressBar();
    });
  }
}
