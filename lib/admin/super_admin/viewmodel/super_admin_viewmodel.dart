import 'package:flutter/foundation.dart';

import '../model/admin_user.dart';
import '../model/division.dart';
import '../model/access_permission.dart';

class SuperAdminViewModel extends ChangeNotifier {
  // ============================================================
  // DIVISION
  // ============================================================

  final List<Division> divisions = [
    Division(
      id: '1',
      name: 'Property Management',
    ),
    Division(
      id: '2',
      name: 'Rental',
    ),
    Division(
      id: '3',
      name: 'Maintenance',
    ),
    Division(
      id: '4',
      name: 'Event',
    ),
    Division(
      id: '5',
      name: 'Finance',
    ),
  ];

  // ============================================================
  // ADMIN USERS
  // ============================================================

  final List<AdminUser> admins = [
    AdminUser(
      id: '1',
      name: 'Andi Pratama',
      email: 'andi@eventary.com',
      division: 'Property Management',
      access: AccessPermission(
        property: true,
        propertyMap: true,
        maintenance: true,
      ),
    ),
    AdminUser(
      id: '2',
      name: 'Budi Santoso',
      email: 'budi@eventary.com',
      division: 'Rental',
      access: AccessPermission(
        property: true,
        propertyMap: true,
        rental: true,
      ),
    ),
    AdminUser(
      id: '3',
      name: 'Citra Lestari',
      email: 'citra@eventary.com',
      division: 'Finance',
      isActive: false,
      access: AccessPermission(
        rental: true,
        finance: true,
      ),
    ),
  ];

  // ============================================================
  // USER
  // ============================================================

  void addAdmin({
    required String name,
    required String email,
    required String division,
  }) {
    admins.add(
      AdminUser(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: name,
        email: email,
        division: division,
      ),
    );

    notifyListeners();
  }

  void updateAdmin({
    required AdminUser admin,
    required String name,
    required String email,
    required String division,
  }) {
    admin.name = name;
    admin.email = email;
    admin.division = division;

    notifyListeners();
  }

  void toggleAdminStatus(AdminUser admin) {
    admin.isActive = !admin.isActive;
    notifyListeners();
  }

  void deleteAdmin(AdminUser admin) {
    admins.removeWhere(
      (item) => item.id == admin.id,
    );

    notifyListeners();
  }

  // ============================================================
  // DIVISION
  // ============================================================

  void addDivision(String name) {
    divisions.add(
      Division(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: name,
      ),
    );

    notifyListeners();
  }

  void updateDivision({
    required Division division,
    required String name,
  }) {
    division.name = name;

    notifyListeners();
  }

  void deleteDivision(Division division) {
    divisions.removeWhere(
      (item) => item.id == division.id,
    );

    notifyListeners();
  }

  // ============================================================
  // ACCESS
  // ============================================================

  void updateAccess(
    AdminUser admin,
    AccessPermission access,
  ) {
    admin.access = access;
    notifyListeners();
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  int get totalAdmins => admins.length;

  int get activeAdmins =>
      admins.where((admin) => admin.isActive).length;

  int get inactiveAdmins =>
      admins.where((admin) => !admin.isActive).length;
}