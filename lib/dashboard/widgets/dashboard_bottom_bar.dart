import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/dashboard/widgets/dashboard_tab.dart';

class DashboardBottomBar extends ConsumerStatefulWidget {
  const DashboardBottomBar({
    Key? key,
    required this.beamerKey,
  }) : super(key: key);

  final GlobalKey<BeamerState> beamerKey;

  @override
  ConsumerState createState() => _DashboardBottomBarState();
}

class _DashboardBottomBarState extends ConsumerState<DashboardBottomBar> {
  late BeamerDelegate _beamerDelegate;

  int get currentTabIndex {
    final location =
        context.currentBeamLocation.state.routeInformation.location ?? '';

    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/pantry')) {
      return 1;
    }
    if (location.startsWith('/recipelibrary')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    if (location.startsWith('/explore')) {
      return 4;
    }

    return 0;
  }

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }

  void _setStateListener() => setState(() {});

  void _tabSelected(int selectedTabIndex) {
    const pathByIndex = {
      0: '/home',
      1: '/pantry',
      2: '/recipelibrary',
      3: '/profile',
      4: '/explore'
    };
    final path = pathByIndex[selectedTabIndex]!;
    _beamerDelegate.beamToNamed(path);
  }

  Widget navItem(int tabIndex) {
    return DashboardTab(
      onTap: () => _tabSelected(tabIndex),
      selected: currentTabIndex == tabIndex,
      tabIndex: tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.44,
            color: Colors.blueGrey,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      height: 96,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < 5; i++) navItem(i),
        ],
      ),
    );
  }
}
