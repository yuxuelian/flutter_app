import 'dart:convert' show json;

class BoolResultBean {
  bool result;

  BoolResultBean.fromParams({this.result});

  factory BoolResultBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BoolResultBean.fromJson(json.decode(jsonStr)) : new BoolResultBean.fromJson(jsonStr);

  BoolResultBean.fromJson(jsonRes) {
    result = jsonRes['result'];
  }

  @override
  String toString() {
    return '{"result": $result}';
  }
}
