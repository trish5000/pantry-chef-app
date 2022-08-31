import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimpleMaterialAppWidget extends StatelessWidget {
  final Widget child;
  final List<Override> overrides;
  final List<NavigatorObserver> navigationObservers;

  const SimpleMaterialAppWidget({
    required this.child,
    this.overrides = const [],
    this.navigationObservers = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        // configProvider.overrideWithValue(FakeConfig()),
        ...overrides,
      ],
      child: MaterialApp(
        home: child,
        navigatorObservers: [
          ...navigationObservers,
        ],
      ),
    );
  }
}
