import 'package:flutter_riverpod/flutter_riverpod.dart';

class FruitsNotifier extends StateNotifier<List<String>> {
  FruitsNotifier() : super(['Apple']);

  void add(String name) {
    state = [...state, name];
  }

  // name when same with element is removed from state
  //name selected and list not same then keep it to state
  void remove(String name) {
    state = [...state.where((element) => element != name)];
  }

  void update(String name, String updatedName) {
    final List<String> updatedList = <String>[];
    for (var i = 0; i < state.length; i++) {
      if (state[i] == name) {
        updatedList.add(updatedName);
      } else {
        updatedList.add(state[i]);
      }
    }
    state = updatedList;
  }
}

//StateNotifierProvider - need 2 define 2 things
//Notifier itself (FruitsNotifier)
//Actual data type of the state (List<String>)
final StateNotifierProvider<FruitsNotifier, List<String>> fruitsProvider =
    StateNotifierProvider<FruitsNotifier, List<String>>((ref) {
  return FruitsNotifier();
});
