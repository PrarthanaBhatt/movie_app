import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget, M>
    extends ConsumerState<T> with VmStateMixin<M> {
  @override
  void initState() {
    viewModel = createModel();
    onModelReady(viewModel);
    super.initState();
  }
}

abstract class BaseState<T extends StatefulWidget, M> extends State<T>
    with VmStateMixin<M> {
  @override
  void initState() {
    viewModel = createModel();
    onModelReady(viewModel);
    super.initState();
  }
}

mixin VmStateMixin<M> {
  late final M viewModel;

  M createModel();

  void onModelReady(M model) {}
}
