import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/features/utils/mappers.dart';
import 'package:flutter/material.dart';

class TransactionTypeDropdown extends StatelessWidget {
  const TransactionTypeDropdown(this.chooseType, {Key? key}) : super(key: key);

  final Function([TransactionType? type]) chooseType;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 65,
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        elevation: 5,
        child: Container(
          width: 210,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            children: [
              _listTileItem(context),
              _listTileItem(context, TransactionType.costs),
              _listTileItem(context, TransactionType.revenue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTileItem(BuildContext context, [TransactionType? type]) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        onTap: () {
          chooseType(type);
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
          child: Text(
            mapTransactionTypeToString(type),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
