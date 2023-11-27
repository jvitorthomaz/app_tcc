import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:tcc_app/src/core/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative{
  RestClient() : super(
    BaseOptions(
      //baseUrl: 'http://192.168.0.12:8080',
      baseUrl: 'http://192.168.0.7:8080',
      //baseUrl: 'http://192.168.1.184:8080',
     // baseUrl: 'http://localhost:8080',
     // baseUrl: 'http://0.0.0.0:8080',
    //  baseUrl: 'http://192.168.0.2:8080',
    //  baseUrl: 'http://192.168.0.14:8080',

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
