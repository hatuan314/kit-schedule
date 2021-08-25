import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:schedule/service/services.dart';

class WebService {
  Dio setupDio() {
    Dio dio = Dio(BaseOptions(
      headers: {'header': 'tkbkma.herokuapp.com'},
      baseUrl: 'https://tkbkma.herokuapp.com/api/schedule/guest',
      contentType: 'application/json; charset=utf-8',
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
    dio.interceptors.add(_setupLoggingInterceptor());

    return dio;
  }

  Interceptor _setupLoggingInterceptor() {
    final interceptor = InterceptorsWrapper(onRequest: (RequestOptions options,
        RequestInterceptorHandler requestInterceptorHandler) {
      options.headers.forEach((k, v) => debugPrint('$k: $v'));
      options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      if (options.data != null) {
//            debugPrint("Body: ${options.data}");
      }
//          debugPrint(
//              "--> END ${options.method != null
//                  ? options.method.toUpperCase()
//                  : 'METHOD'}");
      requestInterceptorHandler.next(options);
    }, onResponse: (Response response,
        ResponseInterceptorHandler responseInterceptorHandler) {
      // do something with data
//          debugPrint(
//              "<-- ${response.statusCode} ${(response.request != null
//                  ? (response.request.baseUrl + response.request.path)
//                  : 'URL')}");
//          debugPrint("Headers:");
//          response.headers?.forEach((k, v) => debugPrint('$k: $v'));
//          debugPrint("Response: ${response.data}");
//          debugPrint("<-- END HTTP");

      _handleResponseException(response); // handling error in response
      responseInterceptorHandler.next(response);
    }, onError:
        (DioError err, ErrorInterceptorHandler errorInterceptorHandler) async {
      // catch error
//          debugPrint(
//              "<-- ${err.message} ${(err.response?.request != null
//                  ? (err.response.request.baseUrl + err.response.request.path)
//                  : 'URL')}");
//          debugPrint(
//              "${err.response != null ? err.response.data : 'Unknown Error'}");
//          debugPrint("<-- End error");
      errorInterceptorHandler.reject(err);
      throw _handleError(err); // handling error in dio
    });

    return interceptor;
  }

  // error of content's response
  _handleResponseException(response) {
    if (response != null && response.statusCode != 200) {
      String errorResponse = response.body;

      if (response.statusCode == 401 || response.statusCode == 401) {
        if (errorResponse.contains('error')) {
          try {
            var errorJson = json.decode(errorResponse);

            String errorOut = errorJson['error'];

            throw UnAuthorizedException(errorOut);
          } on Exception catch (e) {
            throw UnAuthorizedException(e.toString());
          }
        }
      }

      if (errorResponse.contains('error')) {
        try {
          var errorJson = json.decode(errorResponse);

          String errorOut = errorJson['error'];

          throw Exception(errorOut);

          // throw errorOut;
        } on Exception catch (e, b) {
        ("$e \n $b");
          throw UnAuthorizedException(e.toString());
        }
      }
    }
  }

  // error of dio
  _handleError(var error) {
    var responseError;

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          responseError = 'Request to API server was cancelled';
          break;
        case DioErrorType.connectTimeout:
          responseError = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          responseError = "Receive timeout in connection with API server";
          break;
        case DioErrorType.sendTimeout:
          responseError = "Send timeout in connection with API server";
          break;
        case DioErrorType.response:
          responseError =
              "Received invalid status code: ${error.response!.statusCode}";
          break;
        default:
          responseError =
              "Connection to API server failed due to internet connection";
      }
    } else {
      responseError = 'Unexpected error occured: ${error.toString()}';
    }

    throw UnAuthorizedException(responseError);
  }
}
