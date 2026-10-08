import 'package:flutter/material.dart';

import '../model/admin_user.dart';
import '../model/access_permission.dart';
import '../viewmodel/super_admin_viewmodel.dart';

class AccessManagementScreen extends StatefulWidget {
  const AccessManagementScreen({
    super.key,
    required this.viewModel,
  });

  final SuperAdminViewModel viewModel;

  @override
  State<AccessManagementScreen> createState() =>
      _AccessManagementScreenState();
}

class _AccessManagementScreenState
    extends State<AccessManagementScreen> {
  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);
  static const Color border = Color(0xFFE5E5E1);

  AdminUser? selectedAdmin;

  @override
  void initState() {
    super.initState();

    widget.viewModel.addListener(_refresh);

    if (widget.viewModel.admins.isNotEmpty) {
      selectedAdmin = widget.viewModel.admins.first;
    }
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_refresh);
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final admins = widget.viewModel.admins;

    if (admins.isEmpty) {
      return Container(
        color: background,
        child: const Center(
          child: Text(
            'Belum ada akun admin.',
            style: TextStyle(
              color: textGrey,
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    // Pastikan selectedAdmin masih ada
    // setelah admin dihapus dari User Management.
    if (selectedAdmin == null ||
        !admins.contains(selectedAdmin)) {
      selectedAdmin = admins.first;
    }

    return Container(
      color: background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            const SizedBox(height: 28),

            _buildAdminSelector(),

            const SizedBox(height: 25),

            _buildPermissionSection(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Access Management',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Atur fitur yang dapat diakses oleh setiap akun admin.',
          style: TextStyle(
            fontSize: 15,
            color: textGrey,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ADMIN SELECTOR
  // ============================================================

  Widget _buildAdminSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Admin',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: navy,
            ),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<AdminUser>(
            initialValue: selectedAdmin,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person_outline,
              ),
              filled: true,
              fillColor: background,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: border,
                ),
              ),
            ),
            items: widget.viewModel.admins.map(
              (admin) {
                return DropdownMenuItem<AdminUser>(
                  value: admin,
                  child: Text(
                    '${admin.name} - ${admin.division}',
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                selectedAdmin = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PERMISSION SECTION
  // ============================================================

  Widget _buildPermissionSection() {
    final admin = selectedAdmin;

    if (admin == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: gold.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: gold,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      admin.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      admin.division,
                      style: const TextStyle(
                        fontSize: 13,
                        color: textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          const Text(
            'Feature Access',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Pilih fitur yang dapat diakses oleh admin ini.',
            style: TextStyle(
              fontSize: 13,
              color: textGrey,
            ),
          ),

          const SizedBox(height: 18),

          _permissionTile(
            title: 'Property',
            icon: Icons.business_outlined,
            value: admin.access.property,
            onChanged: (value) {
              setState(() {
                admin.access.property = value;
              });
            },
          ),

          _permissionTile(
            title: 'Property Map',
            icon: Icons.map_outlined,
            value: admin.access.propertyMap,
            onChanged: (value) {
              setState(() {
                admin.access.propertyMap = value;
              });
            },
          ),

          _permissionTile(
            title: 'Rental',
            icon: Icons.handshake_outlined,
            value: admin.access.rental,
            onChanged: (value) {
              setState(() {
                admin.access.rental = value;
              });
            },
          ),

          _permissionTile(
            title: 'Maintenance',
            icon: Icons.build_outlined,
            value: admin.access.maintenance,
            onChanged: (value) {
              setState(() {
                admin.access.maintenance = value;
              });
            },
          ),

          _permissionTile(
            title: 'Event',
            icon: Icons.event_outlined,
            value: admin.access.event,
            onChanged: (value) {
              setState(() {
                admin.access.event = value;
              });
            },
          ),

          _permissionTile(
            title: 'Finance',
            icon: Icons.account_balance_wallet_outlined,
            value: admin.access.finance,
            onChanged: (value) {
              setState(() {
                admin.access.finance = value;
              });
            },
          ),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                _saveAccess(admin);
              },
              icon: const Icon(
                Icons.save_outlined,
              ),
              label: const Text(
                'Save Access',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PERMISSION TILE
  // ============================================================

  Widget _permissionTile({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: gold,
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        secondary: Icon(
          icon,
          color: navy,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: navy,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SAVE ACCESS
  // ============================================================

  void _saveAccess(AdminUser admin) {
    final access = AccessPermission(
      property: admin.access.property,
      propertyMap: admin.access.propertyMap,
      rental: admin.access.rental,
      maintenance: admin.access.maintenance,
      event: admin.access.event,
      finance: admin.access.finance,
    );

    widget.viewModel.updateAccess(
      admin,
      access,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Akses ${admin.name} berhasil diperbarui.',
        ),
      ),
    );
  }
}