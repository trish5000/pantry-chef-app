import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider((ref) {
  final dio = Dio();
  dio.options.baseUrl = "http://172.18.0.1:8000";
  dio.options.sendTimeout = 12000;
  return dio;
});
