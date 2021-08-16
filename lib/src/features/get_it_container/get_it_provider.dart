import 'package:budget_manager/injection.dart';
import 'package:budget_manager/src/domain/interactors/calculate_sum_of_transaction_interactor.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_subtype_by_type_interactor.dart';
import 'package:budget_manager/src/domain/interactors/get_transaction_with_request_params_interactor.dart';
import 'package:budget_manager/src/domain/interactors/remove_transaction_interactor.dart';
import 'package:budget_manager/src/domain/repositories/transaction_repository.dart';
import 'package:budget_manager/src/domain/repositories/transaction_subtype_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetItProvider extends ChangeNotifier {
  GetItProvider(
    this.transactionRepository,
    this.transactionSubtypeRepository,
  );

  final TransactionRepository transactionRepository;
  final TransactionSubtypeRepository transactionSubtypeRepository;

  CalculateSumOfTransactionInteractor
      get calculateSumOfTransactionInteractor =>
          getIt<CalculateSumOfTransactionInteractor>();

  GetTransactionSubtypeByTypeInteractor
      get getTransactionSubtypeByTypeInteractor =>
          getIt<GetTransactionSubtypeByTypeInteractor>();

  GetTransactionWithRequestParamsInteractor
      get getTransactionWithRequestParamsInteractor =>
          getIt<GetTransactionWithRequestParamsInteractor>();

  RemoveTransactionInteractor get removeTransactionInteractor =>
      getIt<RemoveTransactionInteractor>();
}
