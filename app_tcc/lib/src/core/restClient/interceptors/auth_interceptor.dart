
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/src/core/constants/local_storage_keys.dart';
import 'package:tcc_app/src/core/ui/app_nav_global_key.dart';

class AuthInterceptor extends Interceptor{

  // identificação do onRequest para adicionar o token as requisições
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler)  async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final preferences = await SharedPreferences.getInstance();

      headers.addAll({
        authHeaderKey: 'Bearer ${preferences.getString(LocalStorageKeys.accessToken)}'
      });
    }

    handler.next(options);
  }

  //Token pode retornar como expirado
  //retorna 403

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

    if (extra case {'DIO_AUTH_KEY': true}) {

      if (response != null && response.statusCode == HttpStatus.forbidden) {

        Navigator.of(AppNavGlobalKey.instance.navKey.currentContext!)
            .pushNamedAndRemoveUntil(
              '/auth/login', 
              (route) => false
            );
            
      }

    }
    handler.reject(err);
  }
}