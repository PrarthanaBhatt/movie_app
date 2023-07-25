// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/constants/enum/gender.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/auth/registration/registration_screen_vm.dart';
import 'package:movie_app/src/utils/helpers/user_sql_helper.dart';

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
  Gender gender = Gender.male;
  String stateValue = '';

  Future<void> _addRegistrationDetail() async {
    await UserSQLHelper.createItem(
        regNameController.text,
        regEmailController.text,
        regDobController.text,
        gender.toString(),
        stateValue.toString(),
        regMobileNumberController.text,
        regPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
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
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    controller: regNameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      FilteringTextInputFormatter.deny(RegExp(r"^\s*")),
                    ],
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Select Gender',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text('Male'),
                        value: Gender.male,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text('Female'),
                        value: Gender.female,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text('Others'),
                        value: Gender.others,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select State',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Flexible(child: StateWidget(
                      getResult: (value) {
                        stateValue = value;
                      },
                    )),
                  ],
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
                            viewModel.validateRegistration(
                                regNameController.text,
                                regEmailController.text,
                                regDobController.text,
                                gender.name,
                                stateValue,
                                regMobileNumberController.text,
                                regPasswordController.text,
                                _onSuccess,
                                _onFailure);
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
    regNameController.clear();
    regEmailController.clear();
    regDobController.clear();
    regMobileNumberController.clear();
    regPasswordController.clear();
  }

  void _onSuccess() {
    _addRegistrationDetail();

    context.go(Routes.loginScreen);
  }

  void _onFailure(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Failed !')),
    );
  }
}

class StateWidget extends StatefulWidget {
  Function(String) getResult;
  StateWidget({
    Key? key,
    required this.getResult,
  }) : super(key: key);

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  String stateValue = '';

  @override
  void initState() {
    super.initState();
    stateValue = 'Maharashtra';
  }

  var states = [
    'Maharashtra',
    'Gujarat',
    'Karnataka',
    'Tamil Nadu',
    'Uttar Pradesh',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      value: stateValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: states.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          stateValue = newValue!;
          widget.getResult.call(stateValue);
        });
      },
    );
  }
}
