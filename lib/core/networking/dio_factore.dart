import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:dio/dio.dart';

class DioFactore {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(baseUrl: ApiEndpoint.baseUrl)
    );  
  }
}
