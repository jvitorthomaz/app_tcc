import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:tcc_app/src/core/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative{
  RestClient() : super(
    BaseOptions(
     baseUrl: 'http://192.168.1.184:8080',


      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
    )
  ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthInterceptor(),
      // PrettyDioLogger(),
    ]);

  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
  
}
