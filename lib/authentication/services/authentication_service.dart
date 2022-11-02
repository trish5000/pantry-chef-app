import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantry_chef_app/authentication/models/authenticate_request.dart';
import 'package:pantry_chef_app/authentication/models/authenticate_response.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';

class AuthenticationService {
  late Dio api;
  late GoogleSignIn googleSignIn;
  AuthenticationService({required this.api, required this.googleSignIn});

  Future<String?> _authorizeWithGoogle() async {
    await googleSignIn.signOut();
    final result = await googleSignIn.signIn();
    final auth = await result?.authentication;
    return auth?.idToken;
  }

  Future<AuthenticateResponse> login() async {
    final idToken = await _authorizeWithGoogle();

    if (idToken == null) {
      throw 'Invalid login';
    }
    final authRequest = AuthenticateRequest()..token = idToken;

    final dioResponse = await api.post(
      '/auth/authenticate',
      data: authRequest.toJson(),
    );
    return AuthenticateResponse.fromJson(dioResponse.data);
  }
}

GoogleSignIn _configureGoogleSignIn(ConfigSettings config) {
  const scopes = ['email', 'openid'];
  if (config.isDesktop) {
    return GoogleSignIn(
      clientId: config.oauthDesktopClientId,
      scopes: scopes,
    );
  }
  // client id is detemined by package name + sha thumbprint for android
  // or plist value for iOS, so not needed here
  return GoogleSignIn(
    scopes: ['email', 'openid'],
  );
}

final authServiceProvider = Provider((ref) {
  final api = ref.watch(apiClientProvider);
  final config = ref.watch(configSettingsProvider);

  final googleSignIn = _configureGoogleSignIn(config);
  return AuthenticationService(googleSignIn: googleSignIn, api: api);
});
