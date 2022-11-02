import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/config_settings.dart';
import 'package:pantry_chef_app/navigation/top_level_router.dart';

Future _registerDesktopPlugin(ConfigSettings config) async {
  if (!config.isDesktop) {
    return;
  }

  await GoogleSignInDart.register(
    clientId: config.oauthDesktopClientId,
  );
}

void main({
  List<Override> overrides = const [],
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(overrides: overrides);
  final userContext = container.read(authProvider.notifier);
  final config = container.read(configSettingsProvider);

  await Future.wait([
    userContext.initialize(),
    config.initialize(),
  ]);

  await _registerDesktopPlugin(config);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PantryChefApp(),
    ),
  );
}

class PantryChefApp extends ConsumerWidget {
  const PantryChefApp({Key? key}) : super(key: key);

  void dismissKeyboard(BuildContext context, WidgetRef ref) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(topLevelRouterProvider);
    return ProviderScope(
      child: GestureDetector(
        onTap: () => dismissKeyboard(context, ref),
        child: MaterialApp.router(
          routerDelegate: router,
          routeInformationParser: BeamerParser(),
          backButtonDispatcher: BeamerBackButtonDispatcher(delegate: router),
          theme: ThemeData(primarySwatch: Colors.green),
        ),
      ),
    );
  }
}
