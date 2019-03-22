import 'dart:io';

import 'package:dio/dio.dart';
import '../bean/index.dart';

import 'dio_util.dart';

import 'dart:convert';

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

  /// 获取用户的房屋信息
  static Future<List<Community>> queryUserHouse() {
    return dio.get('v1/account/app/scene/').then((response) {
      List<Community> res = [];
      for (var dataItem in response.data == null ? [] : response.data) {
        res.add(dataItem == null ? null : Community.fromJson(dataItem));
      }
      return res;
    });
  }
}
