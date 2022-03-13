import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../brand_colors.dart';

class VerificationCodeScreen extends StatelessWidget {
  final AuthController loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (_) => (loginController.isLoading == true)
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Verification Code',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('A 4-digit code has been sent to',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(loginController.phoneNumber!,
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Get.toNamed('phoneVerification');
                                    },
                                    child: Text('Change',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 14,
                                        )))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OTPTextField(
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 50,
                              style: TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              
                              onCompleted: (pin) {
                                loginController.otpVerify(pin);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CountdownTimer(
                              endTime: DateTime.now().millisecondsSinceEpoch +
                                  1000 * 90,
                              widgetBuilder: (_, time) {
                                if (time == null) {
                                  return TextButton(
                                      onPressed: () {},
                                      child: Text('Resend code',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 16,
                                          )));
                                }
                                return Text(
                                  "Resend code in ${time.min ?? '00'} : ${time.sec} ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: BrandColors.colorTextLight,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
