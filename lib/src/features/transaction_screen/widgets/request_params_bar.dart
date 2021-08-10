import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_filter_screen/transaction_filter_screen.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_state.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_sort_screen/transaction_sort_screen.dart';
import 'package:flutter/material.dart';

class RequestParamsBar extends StatelessWidget implements PreferredSizeWidget {
  const RequestParamsBar(
    this.state,
    this.changeState, {
    Key? key,
  }) : super(key: key);

  final TransactionScreenState state;
  final Function(TransactionScreenEvent) changeState;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: _buildSearchField(context),
      actions: [
        _buildSearchButton(),
        _buildSortButton(context),
        _buildFilterButton(context),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return state.isVisibleSearchField
        ? TextField(
            autofocus: true,
            cursorColor: Theme.of(context).focusColor,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).focusColor)),
              hintText: 'Input you text here',
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
  }

  Widget _buildSearchButton() {
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
        icon:
            Icon(state.isVisibleSearchField ? Icons.search_off : Icons.search));
  }

  Widget _buildSortButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showDialog(
          'Ordering',
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
  }

  Widget _buildFilterButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showDialog(
          'Filter',
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
