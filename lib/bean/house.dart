import 'dart:convert' show json;

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
