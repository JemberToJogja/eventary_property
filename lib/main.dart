import 'package:eventary_prototype/eksternal/home/view/external_home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const EventaryApp());
}

class EventaryApp extends StatelessWidget {
  const EventaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventary - Property Visualization',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
      // home: const ExternalHomeScreen(),
    );
  }
}
