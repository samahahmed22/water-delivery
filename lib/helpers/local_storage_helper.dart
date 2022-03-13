import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../../constants.dart';

class LocalStorageHelper extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel user = await _getUser();
      if (user == null) {
        return null;
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(CASHED_USER_DATA);
    return UserModel.fromJson(json.decode(value!));
  }

  setUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(CASHED_USER_DATA, json.encode(user.toJson()));
  }

  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
