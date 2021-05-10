import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news/api/config.dart';
import 'package:news/api/interceptor/dio_connectivity_request_retrier.dart';
import 'package:news/api/interceptor/retry_interceptor.dart';

class Api {
  Api() {
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  static BaseOptions options = new BaseOptions(
    baseUrl: '$baseUrl',
  );
  final Dio dio = Dio(options);

  Future<Response<dynamic>> wrapApi(
      Future<Response<dynamic>> Function() dioApi) async {
    try {
      return await dioApi();
    } catch (error) {
      if (error is DioError && error.type == DioErrorType.response) {
        final Response<dynamic> response = error.response;
        final String errorMessage =
            'Code ${response.statusCode} - ${response.statusMessage}';
        throw DioError(
          requestOptions: error.requestOptions,
          response: error.response,
          type: error.type,
          error: errorMessage,
        );
      }
      rethrow;
    }
  }
}
