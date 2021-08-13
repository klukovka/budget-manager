import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget(this.onSaveClick, {Key? key})
      : super(key: key);

  final void Function() onSaveClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            LocaleKeys.cancel.tr(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        TextButton(
          onPressed: () {
            onSaveClick();
            Navigator.of(context).pop();
          },
          child: Text(
            LocaleKeys.save.tr(),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
