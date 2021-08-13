import 'package:budget_manager/src/domain/entities/transaction_subtype.dart';
import 'package:budget_manager/src/domain/entities/transaction_type.dart';


abstract class TransactionSubtypeRepository {

  Future<List<TransactionSubtype>> getByType(TransactionType? type);
  
}
