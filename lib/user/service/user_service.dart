import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/user/models/user.dart';

class UsersService {
  final UserContext userContext;
  final Dio api;
  UsersService({required this.userContext, required this.api});

  Future<List<User>> getUsers() async {
    final apiResponse = await api.get('/users');
    return apiResponse.data
        .map<User>(
          (i) => User.fromJson(i),
        )
        .toList();
  }

  Future<User> getUser({int? userId}) async {
    userId ??= userContext.user!.id;
    final apiResponse = await api.get('/users/$userId');
    return User.fromJson(apiResponse.data);
  }
}

final userServiceProvider = Provider((ref) {
  final userContext = ref.watch(authProvider);
  final api = ref.watch(apiClientProvider);
  return UsersService(
    userContext: userContext,
    api: api,
  );
});
