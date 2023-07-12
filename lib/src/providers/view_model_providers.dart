import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/ui/auth/login/login_screen_vm.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen_vm.dart';

final loginScreenProvider = Provider.autoDispose(
  (ref) => LoginScreenVm(),
);

final registrationScreenProvider = Provider.autoDispose(
  (ref) => RegistrationScreenVm(),
);
