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
            'Cancel',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        TextButton(
          onPressed: () {
            onSaveClick();
            Navigator.of(context).pop();
          },
          child: Text(
            'Save',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
