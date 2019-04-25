import 'dart:convert' show json;

import 'house_member.dart';

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

    print('house_member = $house_member');
  }

  @override
  String toString() {
    return '{"type": $type,"address": ${address != null ? '${json.encode(address)}' : 'null'},"id": $id,"name": $name,"house_member": $house_member}';
  }
}
