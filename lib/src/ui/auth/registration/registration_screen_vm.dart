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


//Registration Values ==>
//Name : asdf , Email : p@gmail.com, DOB: 03-07-2023, Gender : male, MbNumber : 4854858458, Password : Prarth
//Name : prarthana , Email : p@gmail.com, DOB: 02-07-2023, Gender : female, MbNumber : 9898778899, Password : winitt
//Name : prar , Email : p@gmail.com, DOB: 02-07-2023, Gender : others, MbNumber : 9898778890, Password : winitt