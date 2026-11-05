import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/services/locale/local_server.dart';
import 'package:bookkia/core/utils/app_constance.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactore {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoint.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer ${LocaleHlper.prefs?.getString(AppConstance.userToken)}",
        },
      ),
    );

       dio?.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args){
            // don't print requests with uris containing '/posts' 
            if(options.path.contains('/posts')){
              return false;
            }
            // don't print responses with unit8 list data
            return !args.isResponse || !args.hasUint8ListData;
          }
      )
    );


  }
}
