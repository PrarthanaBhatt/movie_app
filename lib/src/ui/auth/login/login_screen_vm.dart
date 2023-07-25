import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/components/base/base_view_model.dart';
import 'package:movie_app/src/constants/screen_state.dart';
import 'package:movie_app/src/utils/helpers/user_sql_helper.dart';

class LoginScreenVm extends BaseViewModel {
  LoginScreenVm();

  void validateLogin(
    String mobileNumber,
    String password,
    VoidCallback onSuccess,
    ValueChanged<String> onFailure,
  ) {
    UserSQLHelper.getLoginUser(mobileNumber, password).then((userData) {
      if (userData != null) {
        changeUiState(ScreenState.content);

        onSuccess.call();
      } else {
        changeUiState(ScreenState.content);
        onFailure.call("Invalid Creds");
      }
    }).catchError((error) {
      changeUiState(ScreenState.content);
      onFailure.call("Invalid Creds");
    });
  }
}
