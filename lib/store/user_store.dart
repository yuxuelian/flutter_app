import 'package:flutter/foundation.dart';

import '../bean/index.dart';

final userStore = _UserStore();

abstract class BaseUserStore with ChangeNotifier {
  bool get isLogin;

  set isLogin(bool isLogin);

  UserBean get userBean;

  set userBean(UserBean userBean);

  set communityList(List<Community> communityList);

  List<Community> get communityList;

  Community get selectedCommunity;

  set selectedCommunity(Community community);
}

class _UserStore extends BaseUserStore {
  UserBean _userBean;

  List<Community> _communityList;

  bool _isLogin = false;

  Community _selectedCommunity;

  @override
  bool get isLogin => _isLogin;

  @override
  set isLogin(bool isLogin) {
    this._isLogin = isLogin;
    notifyListeners();
  }

  @override
  UserBean get userBean => this._userBean;

  @override
  set userBean(UserBean userBean) {
    this._userBean = userBean;
    notifyListeners();
  }

  @override
  List<Community> get communityList => _communityList;

  @override
  set communityList(List<Community> communityList) {
    this._communityList = communityList;
    notifyListeners();
  }

  @override
  String toString() {
    return 'userBean = ${_userBean.toString()},isLogin = ${isLogin.toString()}';
  }

  @override
  set selectedCommunity(Community index) {
    this._selectedCommunity = index;
    notifyListeners();
  }

  @override
  Community get selectedCommunity => _selectedCommunity;
}
