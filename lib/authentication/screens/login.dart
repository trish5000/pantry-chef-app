import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_chef_app/authentication/models/authenticate_response.dart';
import 'package:pantry_chef_app/authentication/services/authentication_service.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool loading = false;

  void authenticate() async {
    setState(() {
      loading = true;
    });

    final authService = ref.read(authServiceProvider);
    final authContext = ref.read(authProvider.notifier);

    try {
      AuthenticateResponse auth;

      auth = await authService.login();

      authContext.logIn(auth.user!, auth.accessToken!);
      if (!mounted) {
        return;
      }

      context.beamToReplacementNamed('/home', stacked: false);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to Login $err'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget branding() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pantry Chef',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      key: const Key('login-authenticate-fab'),
      onPressed: loading ? null : authenticate,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return null;
        }),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          loading
              ? const CircularProgressIndicator(color: Colors.white)
              : const FaIcon(FontAwesomeIcons.google),
          const SizedBox(width: 10),
          const Text('Sign In With Google')
        ],
      ),
    );
  }

  InputDecoration textDecoration(String text) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintText: text,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.only(top: 20, left: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.greenAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              'Pantry Chef',
              style: Theme.of(context).textTheme.titleLarge!,
            ),
            const Spacer(),
            loginButton(),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
