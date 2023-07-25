import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
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
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Container(
                  height: 150.0,
                  width: 190.0,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Center(
                    child: Image.asset('assets/png/icon.png'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  controller: mobileNumberController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: "Mobile Number",
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (value.length != 10) {
                      return 'Please enter 10 digit mobile number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: TextFormField(
                  maxLength: 6,
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: "Password",
                    counterText: "",
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
                child: Center(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.validateLogin(mobileNumberController.text,
                              passwordController.text, _onSuccess, _onFailure);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid Crediential!')),
                          );
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
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
