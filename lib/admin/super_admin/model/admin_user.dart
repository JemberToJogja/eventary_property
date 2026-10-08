import 'access_permission.dart';

class AdminUser {
  String id;
  String name;
  String email;
  String division;
  bool isActive;
  AccessPermission access;

  AdminUser({
    required this.id,
    required this.name,
    required this.email,
    required this.division,
    this.isActive = true,
    AccessPermission? access,
  }) : access = access ?? AccessPermission();
}