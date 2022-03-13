import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:water_delivery/brand_colors.dart';
import 'package:water_delivery/views/screens/auth/verification_code_screen.dart';

import './helpers/binding.dart';
import 'views/screens/auth/phone_login_screen.dart';
import 'views/screens/auth/verification_code_screen.dart';
import 'views/screens/home_screen.dart';
import './views/screens/location_screen.dart';
import './views/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      initialBinding: Binding(),
      getPages: [
        GetPage(
            name: '/phoneLogin', page: () => PhoneLoginScreen()),
        GetPage(
            name: '/verificationCode', page: () => VerificationCodeScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/location', page: () => LocationScreen()),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: BrandColors.colorPrimaryDark)),
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
