import 'dart:convert' show json;

import '../utils/string_utils.dart';
import 'house.dart';

class QrCodePage {
  String previous;
  int count;
  String next;
  List<QrCodeBean> results;

  QrCodePage.fromParams({this.previous, this.count, this.next, this.results});

  factory QrCodePage(jsonStr) => jsonStr == null ? null : jsonStr is String ? new QrCodePage.fromJson(json.decode(jsonStr)) : new QrCodePage.fromJson(jsonStr);

  QrCodePage.fromJson(jsonRes) {
    previous = jsonRes['previous'];
    count = jsonRes['count'];
    next = jsonRes['next'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(resultsItem == null ? null : new QrCodeBean.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"previous": ${previous != null ? '${json.encode(previous)}' : 'null'},"count": $count,"next": ${next != null ? '${json.encode(next)}' : 'null'},"results": $results}';
  }
}

class QrCodeBean {
  int gender;
  int pass_limit;
  String created_at;
  String expire;
  String house_no;
  String name;
  String phone;
  String qr_code;
  House house;

  QrCodeBean.fromParams({this.gender, this.pass_limit, this.created_at, this.expire, this.house_no, this.name, this.phone, this.qr_code, this.house});

  QrCodeBean.fromJson(jsonRes) {
    gender = jsonRes['gender'];
    pass_limit = jsonRes['pass_limit'];
    created_at = jsonRes['created_at'];
    expire = jsonRes['expire'];
    house_no = jsonRes['house_no'];
    name = jsonRes['name'];
    phone = jsonRes['phone'];
    qr_code = jsonRes['qr_code'];
    house = jsonRes['house'] == null ? null : new House.fromJson(jsonRes['house']);
  }

  @override
  String toString() {
    return '{"gender": $gender,"pass_limit": $pass_limit,"created_at": ${created_at != null ? '${json.encode(created_at)}' : 'null'},"expire": ${expire != null ? '${json.encode(expire)}' : 'null'},"house_no": ${house_no != null ? '${json.encode(house_no)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"phone": ${phone != null ? '${json.encode(phone)}' : 'null'},"qr_code": ${qr_code != null ? '${json.encode(qr_code)}' : 'null'},"house": $house}';
  }

  get fullHouseName => '${removeStart0(house.name)}栋->${removeStart0(house.unit)}单元->${removeStart0(house_no)}号';
}
