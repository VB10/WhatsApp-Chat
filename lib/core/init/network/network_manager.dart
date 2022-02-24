import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  Dio? dio;
  static NetworkManager? get instance {
    if (_instance == null) {
      _instance = NetworkManager._init();
    }
    return _instance;
  }

  NetworkManager._init() {
    final options =
        BaseOptions(baseUrl: "https://hwasampleapi.firebaseio.com/");
    dio = Dio(options);
    dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options,handler) {
        options.path += ".json";
        handler.next(options);
      },
    ));
  }
}
