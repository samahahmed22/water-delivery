import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../brand_colors.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../../controllers/auth_controller.dart';
import '../../widgets/submit_button.dart';
import 'registeration_screen.dart';

class LoginScreen extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(RegisterationScreen());
                      },
                      child: Text("Sign Up",
                          style: TextStyle(
                            color: BrandColors.colorPrimary,
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Sign in to Continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: BrandColors.colorTextLight,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                    label: 'Email',
                    onSave: (value) {
                      controller.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  label: 'Password',
                  onSave: (value) {
                    controller.password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text('Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  onPress: () {
                    _formKey.currentState!.save();

                    if (_formKey.currentState!.validate()) {
                      controller.signInWithEmailAndPassword();
                    }
                  },
                  text: 'LOGIN',
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '-OR-',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButtonSocial(
                  text: 'Login with phone number',
                  onPress: () {
                    Get.toNamed('phoneLogin');
                  },
                  imageName: 'assets/images/phone.png',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButtonSocial(
                  text: 'Login with Facebook',
                  onPress: () {
                    controller.facebookSignInMethod();
                  },
                  imageName: 'assets/images/facebook.png',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButtonSocial(
                  text: 'Login with Google',
                  onPress: () {
                    controller.googleSignInMethod();
                  },
                  imageName: 'assets/images/google.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final String imageName;
  final VoidCallback onPress;

  CustomButtonSocial({
    required this.text,
    required this.imageName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: BrandColors.colorLightGrey,
      ),
      child: FlatButton(
        onPressed: onPress,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image.asset(imageName),
            SizedBox(
              width: 100,
            ),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
