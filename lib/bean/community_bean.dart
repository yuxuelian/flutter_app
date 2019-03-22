import 'dart:convert' show json;
import '../utils/string_utils.dart';

class Community {
  int type;
  String address;
  String id;
  String name;
  List<HouseMember> house_member;

  Community.fromParams({this.type, this.address, this.id, this.name, this.house_member});

  Community.fromJson(jsonRes) {
    type = jsonRes['type'];
    address = jsonRes['address'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    house_member = jsonRes['house_member'] == null ? null : [];

    for (var house_memberItem in house_member == null ? [] : jsonRes['house_member']) {
      house_member.add(house_memberItem == null ? null : new HouseMember.fromJson(house_memberItem));
    }

    print("house_member = $house_member");
  }

  @override
  String toString() {
    return '{"type": $type,"address": ${address != null ? '${json.encode(address)}' : 'null'},"id": $id,"name": $name,"house_member": $house_member}';
  }
}

class HouseMember {
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

  get fullName => '${removeStart0(house.name)}栋->${removeStart0(house.unit)}单元->${removeStart0(house_no)}号';
}

class House {
  int type;
  String id;
  String name;
  String type_name;
  String unit;

  House.fromParams({this.type, this.id, this.name, this.type_name, this.unit});

  House.fromJson(jsonRes) {
    type = jsonRes['type'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    type_name = jsonRes['type_name'];
    unit = jsonRes['unit'];
  }

  @override
  String toString() {
    return '{"type": $type,"id": ${id != null ? '${json.encode(id)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"type_name": ${type_name != null ? '${json.encode(type_name)}' : 'null'},"unit": ${unit != null ? '${json.encode(unit)}' : 'null'}}';
  }
}
