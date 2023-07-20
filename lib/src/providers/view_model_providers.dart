import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/ui/auth/login/login_screen_vm.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen_vm.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard_vm.dart';

final AutoDisposeProvider<LoginScreenVm> loginScreenProvider =
    Provider.autoDispose(
  (ref) => LoginScreenVm(),
);

final AutoDisposeProvider<RegistrationScreenVm> registrationScreenProvider =
    Provider.autoDispose(
  (ref) => RegistrationScreenVm(),
);

final AutoDisposeProvider<MovieDashboardVm> movieDashboardProvider =
    Provider.autoDispose(
  (ref) => MovieDashboardVm(),
);
