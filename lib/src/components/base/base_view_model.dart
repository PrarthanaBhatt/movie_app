import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/constants/screen_state.dart';

class BaseViewModel {
  final List<StreamSubscription> disposables = [];
  final ValueNotifier<ScreenState> _screenStateNotifier =
      ValueNotifier(ScreenState.content);
  ScreenState _uiState = ScreenState.content;

  ValueNotifier<ScreenState> get screenStateNotifier => _screenStateNotifier;

  ScreenState get uiState => _uiState;

  void changeUiState(ScreenState state) {
    _uiState = state;
    _screenStateNotifier.value = state;
  }

  void dispose() {
    for (var element in disposables) {
      element.cancel();
    }
  }
}
