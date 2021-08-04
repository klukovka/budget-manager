import 'package:flutter/material.dart';

class BudgetManagerTextField extends StatelessWidget {
  const BudgetManagerTextField({
    required this.helperText,
    required this.hintText,
    required this.onSubmitted,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String helperText;
  final String hintText;
  final Function(String) onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        onSubmitted: onSubmitted,
        controller: controller,
        cursorColor: Theme.of(context).textTheme.bodyText1!.color,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).accentColor,
          helperText: helperText,
          hintText: hintText,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0),
          ),
        ),
      ),
    );
  }
}
