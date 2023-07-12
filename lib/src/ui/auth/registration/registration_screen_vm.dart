import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/components/base/base_view_model.dart';
import 'package:movie_app/src/constants/screen_state.dart';

class RegistrationScreenVm extends BaseViewModel {
  RegistrationScreenVm();

  void validateRegistration(
    String regNameController,
    String regEmailController,
    String regDobController,
    String gender,
    String stateValue,
    String regMobileNumberController,
    String regPasswordController,
    VoidCallback onSuccess,
    ValueChanged<String> onFailure,
  ) {
    print(
        "Registration Values ==> \n Name : $regNameController , Email : $regEmailController, DOB: $regDobController, Gender : $gender, MbNumber : $regMobileNumberController, Password : $regPasswordController ");
    changeUiState(ScreenState.content);

    onSuccess.call();
  }
}
