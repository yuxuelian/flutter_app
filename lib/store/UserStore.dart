import 'package:scoped_model/scoped_model.dart';

abstract class BaseUserStore extends Model {
  bool get isLogin;

  void setLogin(bool isLogin);

  UserInfo get getUserInfo;

  void setUserInfo(UserInfo userInfo);
}

class UserStore extends BaseUserStore {
  bool loginState = false;

  UserInfo userInfo = UserInfo();

  @override
  bool get isLogin => loginState;

  @override
  void setLogin(bool isLogin) {
    this.loginState = isLogin;
    notifyListeners();
  }

  @override
  UserInfo get getUserInfo => this.userInfo;

  @override
  void setUserInfo(UserInfo userInfo) {
    this.userInfo = userInfo;
    notifyListeners();
  }
}

class UserInfo {
  String phone = "15682070710";
  String version = "1.0.0";
}
