import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';

final apiClientProvider = Provider((ref) {
  final config = ref.watch(configSettingsProvider);
  final userContext = ref.watch(authProvider);

  final dio = Dio();
  dio.options.baseUrl = config.apiEndpoint;
  dio.options.sendTimeout = 12000; // 12 second timeout
  if (userContext.token.isNotEmpty) {
    dio.options.headers['Authorization'] = 'Bearer ${userContext.token}';
  }
  return dio;
});
