import 'package:dio/dio.dart';

import '../constants.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {'Content-Type': 'application/json'},
      ),
    )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}

class DioClient {
  final Dio dio;
  const DioClient(this.dio);
}
