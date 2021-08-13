import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/features/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> mapSubtypeListToMap(
    List<TransactionSubtype>? subtypes) {
  if (subtypes == null) {
    return [];
  }
  return subtypes.map((e) => {'display': e.name, 'value': e}).toList();
}

String mapDateToString(DateTime? date) {
  if (date == null) {
    return '--:--:----';
  }

  return DateFormat('dd.MM.yyyy').format(date);
}

String mapTransactionTypeToString([TransactionType? type]) {
  if (type == TransactionType.costs) {
    return LocaleKeys.costs.tr();
  }

  if (type == TransactionType.revenue) {
    return LocaleKeys.revenue.tr();
  }
  return LocaleKeys.all.tr();
}

IconData mapSubtypeToIcon(TransactionSubtype subtype) {
  switch (subtype.id) {
    case '1':
      return Icons.car_rental;
    case '2':
      return Icons.shop;
    case '3':
      return Icons.book;
    case '4':
      return Icons.person;
    case '5':
      return Icons.money;
    case '6':
      return Icons.present_to_all;
    case '7':
      return Icons.work;
    default:
      return Icons.devices_other;
  }
}

String mapMoneyToString(Transaction transaction) {
  if (transaction.subtype.type == TransactionType.revenue) {
    return '${transaction.amountOfMoney}';
  }
  return '-${transaction.amountOfMoney}';
}

List<TransactionSubtype> mapListDynamicToListSubtype(
    List<dynamic> lisyDynamic) {
  return lisyDynamic.map((e) {
    return _mapListStringToSubtype(
      '$e'.replaceFirst('TransactionSubtype(', '').split(', '),
    );
  }).toList();
}

TransactionSubtype _mapListStringToSubtype(List<String> listString) {
  return TransactionSubtype(
      id: listString[0],
      name: listString[1],
      type: listString[2].contains('costs')
          ? TransactionType.costs
          : TransactionType.revenue);
}
