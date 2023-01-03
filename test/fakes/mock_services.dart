import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_chef_app/authentication/services/authentication_service.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';
import 'package:pantry_chef_app/profile/services/household_service.dart';
import 'package:pantry_chef_app/recipes/services/recipe_service.dart';

class MockPantryService extends Mock implements PantryService {}

class MockBeamerDelegate extends Mock implements BeamerDelegate {}

class MockRecipeService extends Mock implements RecipeService {}

class MockHouseholdService extends Mock implements HouseholdService {}

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserContextNotifier extends Mock implements UserContextNotifier {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockConfigSettings extends Fake implements ConfigSettings {
  @override
  bool get isDesktop => true;

  @override
  String get apiEndpoint => 'api.endpoint';

  @override
  String get oauthDesktopClientId => 'desktopOauth';
}

class FakeGoogleSignInAuthentication extends Fake
    implements GoogleSignInAuthentication {
  @override
  String get idToken => 'token';
}

class FakeGoogleSignInAccount extends Fake implements GoogleSignInAccount {
  @override
  operator ==(other) => true;

  @override
  int get hashCode => 1337;

  @override
  Future<GoogleSignInAuthentication> get authentication =>
      Future.value(FakeGoogleSignInAuthentication());
}
