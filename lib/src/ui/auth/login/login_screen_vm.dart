import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/components/base/base_view_model.dart';
import 'package:movie_app/src/constants/screen_state.dart';
import 'package:movie_app/src/constants/sharedpref_value.dart';
import 'package:movie_app/src/utils/constant.dart';
import 'package:movie_app/src/utils/helpers/user_sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenVm extends BaseViewModel {
  LoginScreenVm();

  void validateLogin(
    String mobileNumber,
    String password,
    VoidCallback onSuccess,
    ValueChanged<String> onFailure,
  ) {
    UserSQLHelper.getLoginUser(mobileNumber, password).then((userData) async {
      if (userData != null) {
        changeUiState(ScreenState.content);
        SharedPrefValue.setPrefValue(isLoggedIn, true);
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
