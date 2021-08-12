import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_screen.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_bloc.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_state.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_sort_screen/transaction_sort_screen.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestParamsBar extends StatelessWidget implements PreferredSizeWidget {
  const RequestParamsBar(
    this.changeState, {
    Key? key,
  }) : super(key: key);

  final Function(TransactionScreenEvent) changeState;

  Widget observe({
    required BlocWidgetBuilder<TransactionScreenState> builder,
    bool Function(TransactionScreenState, TransactionScreenState)? buildWhen,
  }) {
    return BlocBuilder<TransactionScreenBloc, TransactionScreenState>(
      builder: builder,
      buildWhen: buildWhen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: _buildSearchField(),
      actions: [
        _buildSearchButton(),
        _buildSortButton(),
        _buildFilterButton(),
      ],
    );
  }

  Widget _buildSearchField() {
    return observe(builder: (context, state) {
      return state.isVisibleSearchField
          ? TextField(
              autofocus: true,
              cursorColor: Theme.of(context).focusColor,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).focusColor)),
                hintText: LocaleKeys.hintSearchInput.tr(),
                hintStyle: Theme.of(context).textTheme.subtitle1,
              ),
              onChanged: (value) {
                changeState(
                  TransactionScreenParamsEvent(
                    TransactionRequestParams(
                      sort: state.params.sort,
                      filter: TransactionFilter(
                        maxAmountOfMoney: state.params.filter.maxAmountOfMoney,
                        maxDateOfOperation:
                            state.params.filter.maxDateOfOperation,
                        minAmountOfMoney: state.params.filter.minAmountOfMoney,
                        minDateOfOperation:
                            state.params.filter.minDateOfOperation,
                        subtypes: state.params.filter.subtypes,
                        title: value,
                        type: state.params.filter.type,
                      ),
                    ),
                  ),
                );
              },
            )
          : const SizedBox();
    });
  }

  Widget _buildSearchButton() {
    return observe(builder: (context, state) {
      return IconButton(
          onPressed: () {
            changeState(
              SearchFieldEvent(
                visible: !state.isVisibleSearchField,
              ),
            );
            changeState(
              TransactionScreenParamsEvent(
                TransactionRequestParams(
                  sort: state.params.sort,
                  filter: TransactionFilter(
                    maxAmountOfMoney: state.params.filter.maxAmountOfMoney,
                    maxDateOfOperation: state.params.filter.maxDateOfOperation,
                    minAmountOfMoney: state.params.filter.minAmountOfMoney,
                    minDateOfOperation: state.params.filter.minDateOfOperation,
                    subtypes: state.params.filter.subtypes,
                    type: state.params.filter.type,
                  ),
                ),
              ),
            );
          },
          icon: Icon(
              state.isVisibleSearchField ? Icons.search_off : Icons.search));
    });
  }

  Widget _buildSortButton() {
    return observe(builder: (context, state) {
      return IconButton(
        onPressed: () {
          _showDialog(
            LocaleKeys.ordering.tr(),
            TransactionSortScreen((sort) {
              changeState(
                TransactionScreenParamsEvent(
                  TransactionRequestParams(
                    filter: state.params.filter,
                    sort: sort,
                  ),
                ),
              );
            }, state.params.sort),
            context,
          );
        },
        icon: const Icon(Icons.sort),
      );
    });
  }

  Widget _buildFilterButton() {
    return observe(builder: (context, state) {
      return IconButton(
        onPressed: () {
          _showDialog(
            LocaleKeys.filter.tr(),
            TransactionFilterScreen(
              state.params.filter,
              (filter) {
                changeState(
                  TransactionScreenParamsEvent(
                    TransactionRequestParams(
                      filter: filter,
                      sort: state.params.sort,
                    ),
                  ),
                );
              },
            ),
            context,
          );
        },
        icon: const Icon(Icons.filter_alt),
      );
    });
  }

  void _showDialog(String title, Widget content, BuildContext context) {
    showDialog(
      context: context,
      builder: (c) {
        return paramsAlertDialog(
          title,
          content,
          context,
        );
      },
    );
  }

  AlertDialog paramsAlertDialog(
      String title, Widget content, BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      title: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
      content: content,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
