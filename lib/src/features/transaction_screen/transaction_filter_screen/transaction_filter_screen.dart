import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/features/base/base_widget_state.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_bloc.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_state.dart';
import 'package:budget_manager/src/features/transaction_subtypes_list/transaction_subtype_chips.dart';
import 'package:budget_manager/src/features/utils/mappers.dart';
import 'package:budget_manager/src/features/widgets/action_buttons_widget.dart';
import 'package:budget_manager/src/features/widgets/budget_manager_text_field.dart';
import 'package:budget_manager/src/features/widgets/dialog_date_picker.dart';
import 'package:budget_manager/src/features/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _hintTextMinAmount = '12.00';
const _hintTextMaxAmount = '102.00';

class TransactionFilterScreen extends StatefulWidget {
  const TransactionFilterScreen(
    this.initialState,
    this.onClickSave, {
    Key? key,
  }) : super(key: key);

  final Function(TransactionFilter) onClickSave;
  final TransactionFilter initialState;

  @override
  _TransactionFilterScreenState createState() =>
      _TransactionFilterScreenState();
}

class _TransactionFilterScreenState extends BaseWidgetState<
    TransactionFilterScreen,
    TransactionFilterBloc,
    TransactionFilterState,
    TransactionFilterEvent> {
  late final TextEditingController minAmountTextEditingController;
  late final TextEditingController maxAmountTextEditingController;

  @override
  void initState() {
    super.initState();
    minAmountTextEditingController = TextEditingController();
    maxAmountTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    minAmountTextEditingController.dispose();
    maxAmountTextEditingController.dispose();
    super.dispose();
  }

  @override
  TransactionFilterBloc createBloc(BuildContext context) {
    return TransactionFilterBloc();
  }

  @override
  void onBlocCreate(TransactionFilterBloc bloc) {
    bloc.add(GetInitialState(widget.initialState));
  }

  @override
  Widget createChild(BuildContext context) {
    return addListener(
      listener: listener,
      listenWhen: listenWhen,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView(
          children: [
            _buildTitleRow(
              'Money',
              Icons.account_balance_wallet_rounded,
              context,
            ),
            _buildRowFromTo(
              context,
              observe(
                builder: (context, state) {
                  minAmountTextEditingController.text =
                      controllerInitialValue(state.filter.minAmountOfMoney);
                  return _buildFlexibleTextField(
                    'From',
                    _hintTextMinAmount,
                    (minAmount) {
                      sendEvent(
                        context,
                        ChooseMinAmountEvent(minAmount),
                      );
                    },
                    minAmountTextEditingController,
                  );
                },
              ),
              observe(
                builder: (context, state) {
                  maxAmountTextEditingController.text =
                      controllerInitialValue(state.filter.maxAmountOfMoney);
                  return _buildFlexibleTextField(
                    'To',
                    _hintTextMaxAmount,
                    (maxAmount) {
                      sendEvent(
                        context,
                        ChooseMaxAmountEvent(maxAmount),
                      );
                    },
                    maxAmountTextEditingController,
                  );
                },
              ),
            ),
            _buildTitleRow('Dates', Icons.date_range, context),
            _buildRowFromTo(
              context,
              observe(
                builder: (context, state) {
                  return _buildDateButton(
                    context,
                    'From',
                    (date) {
                      sendEvent(context, ChooseMinDateEvent(date));
                    },
                    date: state.filter.minDateOfOperation,
                  );
                },
              ),
              observe(
                builder: (context, state) {
                  return _buildDateButton(
                    context,
                    'To',
                    (date) {
                      sendEvent(
                        context,
                        ChooseMaxDateEvent(date),
                      );
                    },
                    date: state.filter.maxDateOfOperation,
                  );
                },
              ),
            ),
            _buildSubtypesDropdownWidget(),
            observe(
              builder: (context, state) {
                return ActionButtonsWidget(
                  () {
                    widget.onClickSave(state.filter);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void listener(BuildContext context, TransactionFilterState state) {
    if (state.maxAmountError != null) {
      showToast(state.maxAmountError!);
    }
    if (state.minAmountError != null) {
      showToast(state.minAmountError!);
    }

    if (state.dateError != null) {
      showToast(state.dateError!);
    }
  }

  bool listenWhen(TransactionFilterState previousState,
      TransactionFilterState currentState) {
    return previousState.maxAmountError != currentState.maxAmountError ||
        previousState.minAmountError != currentState.minAmountError;
  }

  Widget _buildTitleRow(
    String title,
    IconData icon,
    BuildContext context, [
    double padding = 10.0,
  ]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }

  Widget _buildRowFromTo(BuildContext context, Widget left, Widget rigth) {
    return Row(
      children: [
        left,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            ':',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        rigth,
      ],
    );
  }

  String controllerInitialValue(double? initialValue) {
    return initialValue.toString() == 'null' ? '' : initialValue.toString();
  }

  Widget _buildSubtypesDropdownWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: observe(
        builder: (context, state) {
          return TransactionSubtypeChips(
              state.filter.type,
              state.filter.subtypes ?? [],
              (subtypes) {
                sendEvent(
                  context,
                  ChooseSubtypesEvent(subtypes),
                );
              },
              _buildTitleRow('Types', Icons.line_style, context, 0),
              key: ValueKey(state.filter.type),
             );
        },
      ),
    );
  }

  Widget _buildFlexibleTextField(
    String helperText,
    String hintText,
    Function(String) onSubmitted,
    TextEditingController controller,
  ) {
    return BudgetManagerTextField(
      helperText: helperText,
      hintText: hintText,
      onSubmitted: onSubmitted,
      controller: controller,
    );
  }

  Widget _buildDateButton(
    BuildContext context,
    String helperText,
    Function(DateTime) onDateSelected, {
    DateTime? date,
  }) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogDatePicker(
                        onClickSave: onDateSelected,
                        initialDate: date,
                      );
                    });
              },
              child: Text(mapDateToString(date))),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              helperText,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
