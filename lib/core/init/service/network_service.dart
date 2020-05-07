import 'package:dio/dio.dart';

class NetworkService {
  static NetworkService _instance;
  Dio dio;

  static NetworkService get instance {
    if (_instance == null) {
      _instance = NetworkService.init();
    }
    return _instance;
  }

  NetworkService.init() {
    final options = BaseOptions(
      baseUrl: "https://hwasampleapi.firebaseio.com/",
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) {
        options.path += ".json";
        return options;
      },
    ));
  }
}
