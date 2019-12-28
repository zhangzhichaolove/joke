import 'dart:convert';
import 'package:dio/dio.dart';

class CommonDio {
  // 工厂模式
  factory CommonDio() => _getInstance();

  static CommonDio get instance => _getInstance();
  static CommonDio _instance;

  static Dio dio;
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  CommonDio._internal() {
    // 初始化
    createInstance();
  }

  static CommonDio _getInstance() {
    if (_instance == null) {
      _instance = new CommonDio._internal();
    }
    return _instance;
  }

  /// 创建 dio 实例对象
  Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
//      var options = BaseOptions(
//        connectTimeout: 15000,
//        receiveTimeout: 15000,
//        responseType: ResponseType.plain,
//        validateStatus: (status) {
//          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
//          return true;
//        },
//        baseUrl: "http://192.168.1.168/",
//      );
//      dio = new Dio(options);
      dio = new Dio();
      dio.options
        ..baseUrl = "http://192.168.1.168/"
        ..connectTimeout = 15000
        ..receiveTimeout = 15000
        ..validateStatus = (int state) {
          return state == 200;
        }
        ..headers = {
          'token': 'xx',
        };
    }
    return dio;
  }

  /// 清空 dio 对象
  clear() {
    dio = null;
  }

  void getJson<T>(String url,
      {parameters,
      method,
      Function(T t) onSuccess,
      Function(String error) onError}) async {
    parameters = parameters ?? {};
    method = method ?? 'GET';

    print('请求地址：[' + method + '  ' + url + ']');
    print('请求头：' + dio.options.headers.toString());
    print('请求参数：' + parameters.toString());

    try {
      Response response = await dio.request(url,
          data: parameters,
          queryParameters: parameters,
          options: new Options(method: method));
      final body = json.decode(response.toString());
      if (response.statusCode == 200 && body['code'] == 200) {
        print('响应数据：' + response.toString());
        if (onSuccess != null) {
          onSuccess(body['result']);
        }
      } else {
        print('错误响应：' + response.toString());
        if (onError != null) {
          onError(body['message']);
        }
        //throw Exception('服务器返回错误码:${response.statusCode}');
      }
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
      if (onError != null) {
        onError(e.toString());
      }
    }
  }
}

abstract class DioCallBack {
  void resultData(data);

  void resultError(message);
}
