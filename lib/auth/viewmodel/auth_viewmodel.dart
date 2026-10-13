import 'package:flutter/foundation.dart';

import '../model/auth_user.dart';

class AuthViewModel extends ChangeNotifier {
  final List<AuthUser> _users = [
    const AuthUser(
      id: 'super-001',
      name: 'Super Administrator',
      email: 'superadmin@Iventaris.com',
      password: '123456',
      role: UserRole.superAdmin,
    ),

    const AuthUser(
      id: 'admin-001',
      name: 'Andi Pratama',
      email: 'andi@Iventaris.com',
      password: '123456',
      role: UserRole.admin,
      division: 'Property Management',
    ),

    const AuthUser(
      id: 'admin-002',
      name: 'Budi Santoso',
      email: 'budi@Iventaris.com',
      password: '123456',
      role: UserRole.admin,
      division: 'Rental',
    ),
  ];

  AuthUser? _currentUser;

  AuthUser? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  bool get isSuperAdmin =>
      _currentUser?.role == UserRole.superAdmin;

  bool get isAdmin =>
      _currentUser?.role == UserRole.admin;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final user = _users.where(
      (user) =>
          user.email.toLowerCase() ==
              email.trim().toLowerCase() &&
          user.password == password,
    );

    if (user.isEmpty) {
      return false;
    }

    _currentUser = user.first;

    notifyListeners();

    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}