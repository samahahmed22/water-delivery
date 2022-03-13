import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/submit_button.dart';

class RegisterationScreen extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Registeration",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      label: 'User Name',
                      onSave: (String? value) {
                        controller.name = value!;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      onSave: (String? value) {
                        controller.email = value!;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Phone Number',
                      keyboardType: TextInputType.number,
                      onSave: (String? value) {
                        controller.phoneNumber = value!;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onSave: (String? value) {
                        controller.password = value!;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Confirm password',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onSave: (String? value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter confirm password';
                        }
                        if (value != controller.password) {
                          return 'password and confirm password must be the same';
                        }
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    SubmitButton(
                      onPress: () {
                        _formKey.currentState!.save();

                        if (_formKey.currentState!.validate()) {
                          controller.createAccountWithEmailAndPassword();
                        }
                      },
                      text: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
