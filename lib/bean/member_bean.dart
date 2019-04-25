import 'dart:convert' show json;

import '../utils/string_utils.dart';
import 'house.dart';
import 'user_bean.dart';

class MemberBean {
  String id;
  int type;
  String expire;
  String house_no;
  String type_name;
  House house;
  UserBean user;

  MemberBean.fromParams({this.type, this.expire, this.house_no, this.id, this.type_name, this.house, this.user});

  factory MemberBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MemberBean.fromJson(json.decode(jsonStr)) : new MemberBean.fromJson(jsonStr);

  MemberBean.fromJson(jsonRes) {
    type = jsonRes['type'];
    expire = jsonRes['expire'];
    house_no = jsonRes['house_no'];
    id = jsonRes['id'];
    type_name = jsonRes['type_name'];
    house = jsonRes['house'] == null ? null : new House.fromJson(jsonRes['house']);
    user = jsonRes['user'] == null ? null : new UserBean.fromJson(jsonRes['user']);
  }

  @override
  String toString() {
    return '{"type": $type,"expire": ${expire != null ? '${json.encode(expire)}' : 'null'},"house_no": ${house_no != null ? '${json.encode(house_no)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"type_name": ${type_name != null ? '${json.encode(type_name)}' : 'null'},"house": $house,"user": $user}';
  }

  get fullHouseName => '${removeStart0(house.name)}栋->${removeStart0(house.unit)}单元->${removeStart0(house_no)}号';
}
