import 'package:flutter/material.dart';

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
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.email),
          label: 'Inbox'
        ),
        NavigationDestination(
          icon: Icon(Icons.add),
          label: 'add'
        ),
        NavigationDestination(
          icon: Icon(Icons.thumb_up),
          label: 'liked'
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'profile'
        ),
      ],
    );
  }
}
