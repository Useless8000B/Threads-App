import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class BottomNavigator extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigator({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      indicatorColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          selectedIcon: Icon(TablerIcons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(TablerIcons.mail),
          label: 'Inbox'
        ),
        NavigationDestination(
          icon: Icon(TablerIcons.message_2_plus),
          label: 'add'
        ),
        NavigationDestination(
          icon: Icon(TablerIcons.heart),
          label: 'liked'
        ),
        NavigationDestination(
          icon: Icon(TablerIcons.user),
          label: 'profile'
        ),
      ],
    );
  }
}
