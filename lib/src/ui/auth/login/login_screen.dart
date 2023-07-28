import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (value.length != 10) {
                    return 'Please enter 10 digit mobile number';
                  }
                  return null;
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Color(0xFFF1F1F1)),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  controller: mobileNumberController,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    labelStyle: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: Color(0xFFF1F1F1),
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: "",
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Color(0xFFF1F1F1)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Color(0xFF3466AA), width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
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
                  style: const TextStyle(color: Color(0xFFF1F1F1)),
                  maxLength: 6,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: Color(0xFFF1F1F1),
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: "",
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Color(0xFFF1F1F1)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Color(0xFF3466AA), width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
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
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 24.0),
                        backgroundColor: const Color(0xFF3466AA),
                      ),
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
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
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
