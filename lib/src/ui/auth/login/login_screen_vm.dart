import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/components/base/base_view_model.dart';
import 'package:movie_app/src/constants/screen_state.dart';

class LoginScreenVm extends BaseViewModel {
  LoginScreenVm();

  void validateLogin(
    String mobileNumber,
    String password,
    VoidCallback onSuccess,
    ValueChanged<String> onFailure,
  ) {
    if (mobileNumber == "7776871363" && password == "winjit") {
      changeUiState(ScreenState.content);

      onSuccess.call();
    } else {
      changeUiState(ScreenState.content);
      onFailure.call("Invalid Creds");
    }
  }
}
