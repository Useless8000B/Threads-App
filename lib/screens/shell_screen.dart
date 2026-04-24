import 'package:flutter/material.dart';
import 'package:threads_app/navigation/bottom_navigator.dart';
import 'package:threads_app/screens/add_screen.dart';
import 'package:threads_app/screens/home_screen.dart';
import 'package:threads_app/screens/inbox_screen.dart';
import 'package:threads_app/screens/liked_screen.dart';
import 'package:threads_app/screens/perfil_screen.dart';
import 'package:threads_app/widgets/appbar_widget.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    InboxScreen(),
    AddScreen(),
    LikedScreen(),
    PerfilScreen()
  ];

  void navigate(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      extendBody: true,
      bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: navigate,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.02),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _pages[currentIndex],
      ),
    );
  }
}
