import 'package:budget_manager/src/domain/entities/transaction.dart';
import 'package:budget_manager/src/domain/interactors/base_interactor.dart';


abstract class AddTransactionInteractor
    implements BaseInteractor<Transaction, void> {}
