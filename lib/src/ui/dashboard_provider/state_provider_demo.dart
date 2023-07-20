import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<bool> isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final StateProvider<String> selectedButtonProvider =
    StateProvider<String>((ref) => '');

final Provider<bool> isRedProvider = Provider<bool>((ref) {
  //inside provider you can do any calculations checkings based on that it returns something
  final String color = ref.watch(selectedButtonProvider);
  return color == 'red'; //if color red then its true
});

class StateProviderDemo extends ConsumerWidget {
  const StateProviderDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isRed = ref.watch(isRedProvider);
    final String selectedButton = ref.watch(selectedButtonProvider);
    final bool isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Demo State Provider"),
            !isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        'Load Data',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        ref.read(isLoadingProvider.notifier).state = true;
                        Future.delayed(const Duration(seconds: 3), () {
                          ref.read(isLoadingProvider.notifier).state = false;
                        });
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
            (selectedButton.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Color from selectedBtnProvider ==> $selectedButton"),
                  )
                : const Text("Not selected"),
            ElevatedButton(
              onPressed: () {
                ref.read(selectedButtonProvider.notifier).state = 'red';
              },
              child: const Text("Red"),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectedButtonProvider.notifier).state = 'blue';
              },
              child: const Text("Blue"),
            ),
            isRed ? const Text('Color is red') : const Text('Color is blue'),
          ],
        ),
      ),
    );
  }
}
