import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/features/utils/mappers.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(this._transaction, {Key? key}) : super(key: key);

  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeading(context),
      trailing: _buildTrailing(context),
      title: _buildTitle(context),
      subtitle: _buildSubtitle(context),
      isThreeLine: true,
    );
  }

  Widget _buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Icon(
        mapSubtypeToIcon(_transaction.subtype),
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
 

  Widget _buildTrailing(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        mapMoneyToString(_transaction),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: Text(_transaction.subtype.name,
          style: Theme.of(context).textTheme.subtitle1),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Text(
            _transaction.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 15,
            left: 20,
          ),
          child: Text(
            mapDateToString(_transaction.dateOfOperation),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }

}
