import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen_vm.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreen();
}

class _RegistrationScreen
    extends BaseConsumerState<RegistrationScreen, RegistrationScreenVm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController regNameController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regDobController = TextEditingController();
  TextEditingController regMobileNumberController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Container(
                    height: 110.0,
                    width: 160.0,
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Center(
                      child: Image.asset('assets/png/icon.png'),
                    ),
                  ),
                ),
                const Text(
                  'Registration',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TextFormField(
                    controller: regNameController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TextFormField(
                    controller: regEmailController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@') ||
                          !value.contains('.')) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TextFormField(
                    controller: regDobController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: "DOB",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          regDobController.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Date of Birth';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    controller: regMobileNumberController,
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
                    controller: regPasswordController,
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Registration Success')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Registration Failed!')),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  RegistrationScreenVm createModel() {
    return ref.read(registrationScreenProvider);
  }

  @override
  void dispose() {
    _disposeValues();
    super.dispose();
  }

  void _disposeValues() {
    regMobileNumberController.clear();
    regPasswordController.clear();
  }

  void _onSuccess() {
    context.go(Routes.movieDashboard);
  }

  void _onFailure(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid Credientials!')),
    );
  }
}
