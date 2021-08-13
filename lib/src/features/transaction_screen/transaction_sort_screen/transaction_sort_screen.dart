import 'package:budget_manager/src/domain/entities/sort_by_parametr.dart';
import 'package:budget_manager/src/domain/entities/sort_order.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/features/base/base_bloc_widget.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_sort_screen/transaction_sort_bloc.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_sort_screen/transaction_sort_event.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:budget_manager/src/features/widgets/action_buttons_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionSortScreen extends BaseBlocWidget<TransactionSortBloc,
    TransactionSortParams, TransactionSortEvent> {
  const TransactionSortScreen(this.onClickSave, this.initialState, {Key? key})
      : super(key: key);

  final Function(TransactionSortParams) onClickSave;
  final TransactionSortParams initialState;

  @override
  TransactionSortBloc createBloc(BuildContext context) {
    return TransactionSortBloc();
  }

  @override
  void onBlocCreate(TransactionSortBloc bloc) {
    bloc.add(TransactionInitialEvent(initialState));
  }

  @override
  Widget createChild(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.75,
      child: ListView(
        children: [
          _buildSwitcherWidget(context),
          _buildRadioTileParametr(
            title: LocaleKeys.title.tr(),
            value: SortByParametr.title,
            icon: Icons.title_outlined,
          ),
          _buildRadioTileParametr(
              title: LocaleKeys.money.tr(),
              value: SortByParametr.amountOfMoney,
              icon: Icons.account_balance_wallet_rounded),
          _buildRadioTileParametr(
            title: LocaleKeys.type.tr(),
            value: SortByParametr.subtype,
            icon: Icons.line_style,
          ),
          _buildRadioTileParametr(
            title: LocaleKeys.date.tr(),
            value: SortByParametr.dateOfOperation,
            icon: Icons.date_range,
          ),
          observe(
            builder: (context, state) {
              return ActionButtonsWidget(() {
                onClickSave(state);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitcherWidget(BuildContext context) {
    return ListTile(
      leading: Text(
        LocaleKeys.asc.tr(),
        style: Theme.of(context).textTheme.headline1,
      ),
      title: observe(
        builder: (context, state) {
          return CupertinoSwitch(
            value: state.order == SortOrder.desc,
            onChanged: (value) {
              sendEvent(
                context,
                TransactionSortOrderEvent(
                  value ? SortOrder.desc : SortOrder.asc,
                ),
              );
            },
            activeColor: Theme.of(context).primaryColor,
            trackColor: Theme.of(context).primaryColor,
          );
        },
      ),
      trailing: Text(
        LocaleKeys.desc.tr(),
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildRadioTileParametr({
    required String title,
    required SortByParametr value,
    required IconData icon,
  }) {
    return observe(
      builder: (context, state) {
        return RadioListTile<SortByParametr>(
          title: Text(title, style: Theme.of(context).textTheme.headline2),
          value: value,
          groupValue: state.parametr,
          onChanged: (parametr) {
            sendEvent(context, TransactionSortParametrEvent(parametr!));
          },
          secondary: Icon(icon),
          controlAffinity: ListTileControlAffinity.trailing,
        );
      },
    );
  }
}
