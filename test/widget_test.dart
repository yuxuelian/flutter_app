import 'dart:async';

import 'DemoTest.dart';
import 'package:scan_access/http/dio_util.dart';

void main() async {
//  var dio = DioUtil.getInstance().dio;
//  //发起单个请求
//  final response = await dio.get("https://jsonplaceholder.typicode.com/posts");
////  print(response.data);
//  print("--------------------------------------------------------------");
//  //同时发起多个请求
//  final futures = await Future.wait([dio.get("https://jsonplaceholder.typicode.com/posts")]);
//  futures.forEach((response) {
//    var demoTest = DemoTest.fromJson(response.data[0]);
//    print(demoTest.toString());
//  });

  print(DateTime.now().millisecondsSinceEpoch);
}
