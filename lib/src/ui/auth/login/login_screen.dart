import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/components/widgets/common_app_button.dart';
import 'package:movie_app/src/components/widgets/common_text_form_field.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/auth/login/login_screen_vm.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends BaseConsumerState<LoginScreen, LoginScreenVm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  height: 150.0,
                  width: 190.0,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Center(
                    child: Image.asset('assets/png/movie_icon.png'),
                  ),
                ),
              ),
              CommonTextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                labelText: 'Mobile Number',
                controller: mobileNumberController,
                onChanged: (value) {
                  print("Value changes $value");
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (value.length != 10) {
                    return 'Please enter 10 digit mobile number';
                  }
                  return null;
                },
              ),
              CommonTextFormField(
                maxLength: 6,
                labelText: 'Password',
                obscureText: true,
                controller: passwordController,
                style: const TextStyle(
                  letterSpacing: 6,
                  color: Color(0xFFF1F1F1),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: "OpenSans",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Please enter password correctly, it is less then 6 charachters';
                  }
                  return null;
                },
              ),
              CommonAppButton(
                text: 'Submit',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.validateLogin(mobileNumberController.text,
                        passwordController.text, _onSuccess, _onFailure);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid Crediential!')),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Does not have account ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3466AA),
                      ),
                    ),
                    onPressed: () {
                      context.push(Routes.registrationScreen);
                    },
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF3466AA),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginScreenVm createModel() {
    return ref.read(loginScreenProvider);
  }

  @override
  void dispose() {
    _disposeValues();
    super.dispose();
  }

  void _disposeValues() {
    mobileNumberController.clear();
    passwordController.clear();
  }

  void _onSuccess() {
    // context.go(Routes.movieDashboard);

    context.go(Routes.movieDBDashboardScreen);
  }

  void _onFailure(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid Credientials!')),
    );
  }
}
