import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardTab extends StatelessWidget {
  final VoidCallback onTap;
  final bool selected;
  final int tabIndex;

  const DashboardTab(
      {Key? key,
      required this.onTap,
      required this.selected,
      required this.tabIndex})
      : super(key: key);

  static const iconByIndex = {
    0: FaIcon(FontAwesomeIcons.house),
    1: FaIcon(FontAwesomeIcons.kitchenSet),
    2: FaIcon(FontAwesomeIcons.book),
    3: FaIcon(FontAwesomeIcons.person),
    4: FaIcon(FontAwesomeIcons.magnifyingGlass),
  };

  static const titleByIndex = {
    0: 'Home',
    1: 'Pantry',
    2: 'Recipe Library',
    3: 'Profile',
    4: 'Explore',
  };

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10);
    final bool dense = MediaQuery.of(context).size.width <= 375;
    final width = dense ? 54.0 : 64.0;
    const height = 64.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: radius,
          color: selected ? Colors.grey.withOpacity(0.16) : null,
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: iconByIndex[tabIndex]!),
              const SizedBox(height: 6),
              Text(
                titleByIndex[tabIndex]!.toUpperCase(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
