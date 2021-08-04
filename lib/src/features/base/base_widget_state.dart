import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseWidgetState<W extends StatefulWidget, B extends Bloc<E, S>,
    S, E> extends State<W> {
  B createBloc(BuildContext context);

  Widget createChild(BuildContext context);

  void onBlocCreate(B bloc) {}

  void sendEvent(BuildContext context, E event) {
    BlocProvider.of<B>(context).add(event);
  }

  Widget observe({
    required BlocWidgetBuilder<S> builder,
    bool Function(S, S)? buildWhen,
  }) {
    return BlocBuilder<B, S>(
      builder: builder,
      buildWhen: buildWhen,
    );
  }

  Widget addListener({
    required void Function(BuildContext, S) listener,
    required Widget child,
    bool Function(S, S)? listenWhen,
  }) {
    return BlocListener<B, S>(
      listener: listener,
      listenWhen: listenWhen,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      lazy: true,
      create: (context) {
        var bloc = createBloc(context);
        onBlocCreate(bloc);
        return bloc;
      },
      child: Builder(builder: (c) => createChild(c)),
    );
  }
}
