import 'dart:io';
import 'package:dio/dio.dart';
import '../utils/prefs_util.dart';

class DioUtil {
  static DioUtil _instance;

  static DioUtil getInstance() {
    if (_instance == null) {
      _instance = DioUtil._();
    }
    return _instance;
  }

  Dio dio;

  DioUtil._() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://118.89.19.78:7000/',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      contentType: ContentType.json,
    );
    dio = Dio(options);
    // 添加 Token 拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        // 获取存储在磁盘上的  token  信息
        final token = await PrefsUtil.getToken();
        // 是否存储了  token  信息
        if (token.isNotEmpty) {
          // token  存在  则添加到请求头中
          options.headers['Authorization'] = 'JWT $token';
        }
        options.headers['Connection'] = 'close';
        return options;
      },
      onResponse: (Response response) {
        return response;
      },
      onError: (DioError e) {
        return e;
      },
    ));
  }
}
