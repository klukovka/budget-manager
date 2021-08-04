import 'package:budget_manager/src/features/widgets/action_buttons_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogDatePicker extends StatefulWidget {
  const DialogDatePicker({
    required this.onClickSave,
    Key? key,
    this.initialDate,
  }) : super(key: key);

  final DateTime? initialDate;
  final Function(DateTime) onClickSave;

  @override
  _DialogDatePickerState createState() => _DialogDatePickerState();
}

class _DialogDatePickerState extends State<DialogDatePicker> {
  late DateTime date;

  @override
  void initState() {
    date = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.6,
        child: CupertinoDatePicker(
          maximumDate: DateTime.now(),
          onDateTimeChanged: (pickedDate) {
            setState(() {
              date = pickedDate;
            });
          },
          initialDateTime: date,
          mode: CupertinoDatePickerMode.date,
        ),
      ),
      actions: [
        ActionButtonsWidget(() {
          widget.onClickSave(date);
        })
      ],
    );
  }
}
