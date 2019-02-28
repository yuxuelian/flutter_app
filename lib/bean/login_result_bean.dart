import 'dart:convert' show json;
import 'user_bean.dart';

class LoginResultBean {
  String token;
  UserBean user;

  LoginResultBean.fromParams({this.token, this.user});

  factory LoginResultBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new LoginResultBean.fromJson(json.decode(jsonStr)) : new LoginResultBean.fromJson(jsonStr);

  LoginResultBean.fromJson(jsonRes) {
    token = jsonRes['token'];
    user = jsonRes['user'] == null ? null : new UserBean.fromJson(jsonRes['user']);
  }

  @override
  String toString() {
    return '{"token": ${token != null ? '${json.encode(token)}' : 'null'},"user": $user}';
  }
}
