import 'dart:convert' show json;

class UserBean {
  String avatar;
  String id;
  String key;
  String nickname;
  String username;

  UserBean.fromParams({this.avatar, this.id, this.key, this.nickname, this.username});

  UserBean.fromJson(jsonRes) {
    avatar = jsonRes['avatar'];
    id = jsonRes['id'];
    key = jsonRes['key'];
    nickname = jsonRes['nickname'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"key": ${key != null ? '${json.encode(key)}' : 'null'},"nickname": ${nickname != null ? '${json.encode(nickname)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
