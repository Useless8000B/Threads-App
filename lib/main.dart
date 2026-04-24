import 'package:flutter/material.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/screens/shell_screen.dart';

void main() {
  runApp(const Threads());
}

class Threads extends StatelessWidget {
  const Threads({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Threads',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white, brightness: Brightness.dark),

        appBarTheme: AppBarThemeData(
          backgroundColor: AppColors.black,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24
          )
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.black,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          iconTheme: WidgetStateProperty.fromMap({
            WidgetState.selected: const IconThemeData(size: 28, color: Colors.white),
            WidgetState.any: const IconThemeData(size: 28, color: AppColors.grey),
          }),
        ),
        scaffoldBackgroundColor: AppColors.black
      ),
      home: const ShellScreen(),
    );
  }
}
