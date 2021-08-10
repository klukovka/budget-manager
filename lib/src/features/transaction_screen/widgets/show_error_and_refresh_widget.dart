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
          'Failed to load. Error: $error',
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
