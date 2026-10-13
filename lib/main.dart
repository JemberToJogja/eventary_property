import 'package:eventary_prototype/admin/super_admin/view/super_admin_dashboard_screen.dart';
import 'package:eventary_prototype/auth/view/internal_login_screen.dart';
import 'package:eventary_prototype/auth/viewmodel/auth_viewmodel.dart';
import 'package:eventary_prototype/eksternal/home/view/external_shell_screen.dart';
import 'package:eventary_prototype/admin/screens/home_screen.dart';
import 'package:eventary_prototype/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  // Menggunakan URL tanpa #
  usePathUrlStrategy();

  runApp(const EventaryApp());
}

class EventaryApp extends StatelessWidget {
  const EventaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = AuthViewModel();

    return MaterialApp(
      title: 'Iventaris - Property Visualization',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),

      routes: {
        // =========================
        // EXTERNAL / PUBLIC
        // =========================
        '/': (context) => const ExternalShellScreen(),

        // =========================
        // INTERNAL LOGIN
        // =========================
        '/login': (context) => InternalLoginScreen(
              authViewModel: authViewModel,
            ),

        // =========================
        // SUPER ADMIN
        // =========================
        '/super-admin': (context) =>
            const SuperAdminDashboardScreen(),

        // =========================
        // ADMIN
        // =========================
        '/admin': (context) => const HomeScreen(),
      },
    );
  }
}