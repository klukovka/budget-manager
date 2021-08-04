import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/features/transaction_screen/widgets/transacton_tile.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList(this.transactions, {Key? key}) : super(key: key);

  final List<Transaction>? transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions == null || transactions!.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Empty List',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 20,
          ),
          const Icon(Icons.mood_bad),
        ],
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) => TransactionTile(
        transactions![index],
      ),
      itemCount: transactions!.length,
    );
  }
}
