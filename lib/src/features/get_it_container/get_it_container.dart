import 'package:budget_manager/injection.dart';
import 'package:budget_manager/src/budget_manager_app.dart';
import 'package:budget_manager/src/features/get_it_container/get_it_provider.dart';
import 'package:budget_manager/src/features/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetItContainer extends StatefulWidget {
  const GetItContainer({Key? key}) : super(key: key);

  @override
  _GetItContainerState createState() => _GetItContainerState();
}

class _GetItContainerState extends State<GetItContainer> {
  @override
  void initState() {
    super.initState();
    configureDependencies(Env.devStatic);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<GetItProvider>(),
      child: const BudgetManagerApp(),
    );
  }
}
