import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../bean/index.dart';

class PrefsUtil {
  PrefsUtil._();

  static const _TOKEN = 'token';
  static const _USER_BEAN = 'user_bean';

  static Future<String> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_TOKEN) ?? '';
  }

  static Future<UserBean> getUserBean() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userBeanStr = sharedPreferences.getString(_USER_BEAN);
    if (userBeanStr != null) {
      return UserBean.fromJson(json.decode(userBeanStr));
    } else {
      return null;
    }
  }

  static Future<bool> saveToken(String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(_TOKEN, value);
  }

  static Future<bool> saveUserBean(UserBean value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(_USER_BEAN, value.toString());
  }

  static Future<bool> clear() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
