import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/ui/dashboard_provider/state_notifier_provider_list/fruits_notifier.dart';

class StateNotifierProviderList extends ConsumerWidget {
  const StateNotifierProviderList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> fruits = ref.watch(fruitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(fruitsProvider.notifier)
              .add('Fruit ${Random().nextInt(100)}');
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: fruits
              .map((value) => GestureDetector(
                    onLongPress: () {
                      ref
                          .read(fruitsProvider.notifier)
                          .update(value, '$value updated');
                    },
                    onTap: () {
                      ref.read(fruitsProvider.notifier).remove(value);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(value),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
