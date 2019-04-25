import 'dart:convert' show json;
import 'house.dart';
import '../utils/string_utils.dart';

class HouseMember {
  // 可生成人员
  static final ENABLE_CREATE_MEMBER = 1;
  // 可邀请访客
  static final ENABLE_INVITE_VISITOR = 2;
  // 不可邀请访客
  static final DISABLE_INVITE_VISITOR = 3;
  // 租客(可邀请访客)
  static final TENANT = 4;

  int type;
  String expire;
  String house_no;
  String id;
  String type_name;
  House house;

  HouseMember.fromParams({this.type, this.expire, this.house_no, this.id, this.type_name, this.house});

  HouseMember.fromJson(jsonRes) {
    type = jsonRes['type'];
    expire = jsonRes['expire'];
    house_no = jsonRes['house_no'];
    id = jsonRes['id'];
    type_name = jsonRes['type_name'];
    house = jsonRes['house'] == null ? null : new House.fromJson(jsonRes['house']);
  }

  @override
  String toString() {
    return '{"type": $type,"expire": ${expire != null ? '${json.encode(expire)}' : 'null'},"house_no": ${house_no != null ? '${json.encode(house_no)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"type_name": ${type_name != null ? '${json.encode(type_name)}' : 'null'},"house": $house}';
  }

  get fullHouseName => '${removeStart0(house.name)}栋->${removeStart0(house.unit)}单元->${removeStart0(house_no)}号';
}
