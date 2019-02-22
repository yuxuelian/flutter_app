import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() async {
  List widgets = [];
  //发起单个请求
  final response = await http.get("https://jsonplaceholder.typicode.com/posts");
  print(response.body);
  print("--------------------------------------------------------------");
  //同时发起多个请求
  final futures = await Future.wait(
      [http.get("https://jsonplaceholder.typicode.com/posts")]);
  futures.forEach((response) {
    widgets = json.decode(response.body);
    print(widgets);
  });
}
