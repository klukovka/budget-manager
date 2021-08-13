import 'package:budget_manager/src/data/repositories/mock_transaction_repository_impl.dart';
import 'package:budget_manager/src/domain/entities/transaction_filter.dart';
import 'package:budget_manager/src/domain/entities/transaction_request_params.dart';
import 'package:budget_manager/src/domain/entities/transaction_sort_params.dart';
import 'package:budget_manager/src/domain/interactors/calculate_sum_of_transaction_interactor.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_with_request_params_interactor.dart';
import 'package:budget_manager/src/domain/interactors/remove_transaction_interactor.dart';
import 'package:budget_manager/src/features/base/base_bloc_widget.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_bloc.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_event.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen_state.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/budget_manager_progress_bar.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/show_error_and_refresh_widget.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/transactions_list.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/request_params_bar.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/transaction_type_dropdown.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:budget_manager/src/features/utils/mappers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends BaseBlocWidget<TransactionScreenBloc,
    TransactionScreenState, TransactionScreenEvent> {
  const TransactionScreen({Key? key}) : super(key: key);

  static String get screenName => 'transaction_screen';

  @override
  TransactionScreenBloc createBloc(BuildContext context) {
    final _repository = MockTransactionRepositoryImpl();
    return TransactionScreenBloc(
      CalculateSumOfTransactionInteractor(_repository),
      GetTransactionWithRequestParamsInteractor(_repository),
      RemoveTransactionInteractor(_repository),
    );
  }

  @override
  void onBlocCreate(TransactionScreenBloc bloc) {
    bloc.add(TransactionScreenParamsEvent(
      TransactionRequestParams(
        sort: const TransactionSortParams(),
        filter: TransactionFilter(
          maxDateOfOperation: DateTime.now(),
          minDateOfOperation: DateTime.now().subtract(
            const Duration(days: 30),
          ),
        ),
      ),
    ));
  }

  @override
  Widget createChild(BuildContext context) {
    return Scaffold(
      appBar: RequestParamsBar((event) {
        sendEvent(context, event);
      }),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildTypeInfoWidget(context),
          _buildTransactionStateWidget(),
          _buildDropDown(),
        ],
      ),
      drawer: _buildSettingsDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTypeInfoWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildChooseTypeWidget(),
          _buildMoneyStateWidget(),
        ],
      ),
    );
  }

  Widget _buildChooseTypeWidget() {
    return observe(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Material(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            splashColor: Theme.of(context).splashColor,
            onTap: () {
              sendEvent(
                context,
                ContextMenuEvent(visible: !state.isVisibleContextMenu),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.only(
                right: 15,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  if (state.isVisibleContextMenu)
                    const Icon(Icons.arrow_drop_down)
                  else
                    const Icon(Icons.arrow_right),
                  Text(
                    mapTransactionTypeToString(
                      state.params.filter.type,
                    ),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMoneyStateWidget() {
    return observe(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '${state.sum} ${LocaleKeys.uah.tr()}',
            style: Theme.of(context).textTheme.headline2,
          ),
        );
      },
    );
  }

  Widget _buildTransactionStateWidget() {
    return observe(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height <
                  MediaQuery.of(context).size.width
              ? MediaQuery.of(context).size.height * 0.6
              : MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: state.error != null
              ? ShowErrorAndRefreshWidget(state.error!, () {
                  sendEvent(context, TransactionScreenReloadEvent());
                })
              : state.loading
                  ? const BudgetManagerProgressBar()
                  : TransactionsList(state.transactions),
        );
      },
    );
  }

  Widget _buildDropDown() {
    return observe(
      builder: (context, state) {
        if (state.isVisibleContextMenu) {
          return TransactionTypeDropdown(
            ([type]) {
              sendEvent(context, ContextMenuEvent(visible: false));
              sendEvent(
                context,
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
                      title: state.params.filter.title,
                      type: type,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Drawer _buildSettingsDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${LocaleKeys.language.tr()}'
                ' (${LocaleKeys.languageName.tr()})',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            _buildLanguageButton('English', 'en', context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildLanguageButton('Українська', 'uk', context),
            ),
            _buildLanguageButton('Русский', 'ru', context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
      String language, String locale, BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await context.setLocale(Locale(locale));
      },
      child: Text(
        language,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
