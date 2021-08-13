import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShowErrorAndRefreshWidget extends StatelessWidget {
  const ShowErrorAndRefreshWidget(
    this.error,
    this.refresh, {
    Key? key,
  }) : super(key: key);

  final String error;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${LocaleKeys.failedToLoad.tr()} $error',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          onPressed: () {
            refresh();
          },
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
