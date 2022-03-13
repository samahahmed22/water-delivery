import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/custom_text_form_field.dart';

class PhoneLoginScreen extends StatelessWidget {
  final AuthController loginController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (_) => (loginController.isLoading == true)
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Phone verification",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        'To proceed please enter your phone number  \n\n we will send you one time SMS message',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    label: 'Mobile Number',
                                    keyboardType: TextInputType.phone,
                                    onSave: (String? value) {
                                      loginController.verifyPhone(value!);
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SubmitButton(
                            onPress: () {
                              if (!_formKey.currentState!.validate()) {
                                // Invalid!
                                return;
                              }
                              _formKey.currentState!.save();

                              Get.toNamed('verificationCode');
                            },
                            text: 'Verify',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
