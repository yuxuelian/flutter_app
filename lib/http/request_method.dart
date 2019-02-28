import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scan_access/bean/bool_result_bean.dart';
import 'package:scan_access/bean/login_result_bean.dart';

import 'dio_util.dart';

const GET = 'get';
const POST = 'post';

class RequestApi {
  RequestApi._();

  static final dio = DioUtil.getInstance().dio;

  /// 发送短信验证码
  static Future<BoolResultBean> sendAuthCode(String phone) {
    final options = Options(
      method: POST,
      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    );
    final data = {
      'phone': phone,
    };
    return dio.request('v1/account/users/auth-code/', data: data, options: options).then((response) => BoolResultBean.fromJson(response.data));
  }

  /// 短信验证码登录
  static Future<LoginResultBean> smsLogin(String phone, String authCode) {
    final options = Options(
      method: POST,
      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    );
    final data = {
      'phone': phone,
      'code': authCode,
    };
    return dio.request('v1/account/users/sms-login/', data: data, options: options).then((response) => LoginResultBean.fromJson(response.data));
  }

  /// 密码登录
  static Future<LoginResultBean> pwdLogin(String phone, String password) {
    final options = Options(
      method: POST,
      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    );
    final data = {
      'phone': phone,
      'password': password,
    };
    return dio.request('v1/account/users/password-login/', data: data, options: options).then((response) => LoginResultBean.fromJson(response.data));
  }

  /// 刷新 token
  static Future<LoginResultBean> refreshToken() {
    return dio.post('v1/account/users/token-login/').then((response) => LoginResultBean.fromJson(response.data));
  }
}
