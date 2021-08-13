import 'package:budget_manager/src/domain/entities/transaction_type.dart';
import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/repositories/transaction_subtype_repository.dart';
import 'package:budget_manager/src/features/utils/env.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: TransactionSubtypeRepository, env: [Env.devStatic])
class MockTransactionSubtypeRepositoryImpl
    implements TransactionSubtypeRepository {
  List<TransactionSubtype> subtypes = [
    const TransactionSubtype(
      id: '1',
      name: 'Transport',
      type: TransactionType.costs,
    ),
    const TransactionSubtype(
      id: '2',
      name: 'Shopping',
      type: TransactionType.costs,
    ),
    const TransactionSubtype(
      id: '3',
      name: 'Education',
      type: TransactionType.costs,
    ),
    const TransactionSubtype(
      id: '4',
      name: 'Hobby',
      type: TransactionType.costs,
    ),
    const TransactionSubtype(
      id: '5',
      name: 'Salary',
      type: TransactionType.revenue,
    ),
    const TransactionSubtype(
      id: '6',
      name: 'Gift',
      type: TransactionType.revenue,
    ),
    const TransactionSubtype(
      id: '7',
      name: 'Part-time job',
      type: TransactionType.revenue,
    ),
  ];

  @override
  Future<List<TransactionSubtype>> getByType(TransactionType? type) async {
    if (type == null) {
      return subtypes;
    }
    return subtypes.where((element) => element.type == type).toList();
  }
}
