import 'dart:convert' show json;

class DemoTest {
  int id;
  int userId;
  String body;
  String title;

  DemoTest.fromParams({this.id, this.userId, this.body, this.title});

  factory DemoTest(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DemoTest.fromJson(json.decode(jsonStr)) : new DemoTest.fromJson(jsonStr);

  DemoTest.fromJson(jsonRes) {
    id = jsonRes['id'];
    userId = jsonRes['userId'];
    body = jsonRes['body'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"id": $id,"userId": $userId,"body": ${body != null ? '${json.encode(body)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}
