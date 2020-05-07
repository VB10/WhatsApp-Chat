import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatchats/core/init/service/network_service.dart';

main() {
  Dio dio;

  setUp(() {
    dio = NetworkService.init().dio;
  });

  test("Get All Chat Data", () {});
}
