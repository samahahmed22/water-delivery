import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '../views/screens/auth/registeration_screen.dart';
import '../views/screens/home_screen.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../helpers/local_storage_helper.dart';

class AuthController extends GetxController {
  final LocalStorageHelper localStorageHelper = Get.find();

  bool isLoading = false;
  String verId = '';
  RxString authStatus = ''.obs;
  String? email, password, name, phoneNumber;

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();

  // UserModel? _user;

  verifyPhone(String phone) async {
    phoneNumber = phone;
    isLoading = true;
    await _auth.verifyPhoneNumber(
        timeout: Duration(seconds: 50),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {
          if (_auth.currentUser != null) {
            isLoading = false;
            authStatus.value = "login successfully";
          }
        },
        verificationFailed: (authException) {
          Get.snackbar("sms code info", "otp code hasn't been sent!!");
        },
        codeSent: (String id, int? forceResent) {
          isLoading = false;
          this.verId = id;
          authStatus.value = "login successfully";
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
        });
    update();
  }

  otpVerify(String otp) async {
    isLoading = true;
    try {
      UserCredential userCredential = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verId, smsCode: otp));
      if (userCredential.user != null) {
        isLoading = false;
        Get.to(RegisterationScreen());
      }
    } on Exception catch (e) {
      Get.snackbar("otp info", "otp code is not correct, please try again",
          colorText: Colors.red,
          isDismissible: true,
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      Get.offAll(HomeScreen());
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createAccountWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(HomeScreen());
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void googleSignInMethod() async {
    print('hhhhhhhhhhh');
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print('hhhhhhhhhhh.........');
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    print('hhhhhhhhhhh.........3333333333');
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user);
      Get.offAll(HomeScreen());
    });
  }

  void facebookSignInMethod() async {
    print('hhhhhhhhhhh');
    final FacebookLoginResult result = await _facebookLogin.logIn(['email']);
    print('hhhhhhhhhhh.................');
    final accessToken = result.accessToken!.token;
    print('hhhhhhhhhhh.........3333333333');
    if (result.status == FacebookLoginStatus.loggedIn) {
      // you are logged

      final facebookCredential = FacebookAuthProvider.credential(accessToken);
      await _auth.signInWithCredential(facebookCredential).then((user) async {
        saveUser(user);
        Get.offAll(HomeScreen());
      });
    } else {
      print(result.status);
    }
  }

  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      id: user.user!.uid,
      email: user.user!.email!,
      name: name == null ? user.user!.displayName : name,
      phoneNumber: phoneNumber == null ? user.user!.phoneNumber : phoneNumber,
    );
    await FireStoreService().addUserToFireStore(userModel);
    setUser(userModel);
  }

  void setUser(UserModel user) async {
    await localStorageHelper.setUser(user);
  }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStorageHelper.deleteUser();
  }
}
