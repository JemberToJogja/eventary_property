import 'package:flutter/material.dart';

import '../model/admin_user.dart';
import '../viewmodel/super_admin_viewmodel.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({
    super.key,
    required this.viewModel,
  });

  final SuperAdminViewModel viewModel;

  @override
  State<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState
    extends State<UserManagementScreen> {
  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);
  static const Color border = Color(0xFFE5E5E1);

  @override
  void initState() {
    super.initState();

    widget.viewModel.addListener(_refresh);
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
  // ADD / EDIT ADMIN
  // ============================================================

  void showAdminForm({AdminUser? admin}) {
    final nameController = TextEditingController(
      text: admin?.name ?? '',
    );

    final emailController = TextEditingController(
      text: admin?.email ?? '',
    );

    final divisions = widget.viewModel.divisions;

    String? selectedDivision;

    if (admin != null &&
        divisions.any(
          (division) => division.name == admin.division,
        )) {
      selectedDivision = admin.division;
    } else if (divisions.isNotEmpty) {
      selectedDivision = divisions.first.name;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                admin == null
                    ? 'Add Admin'
                    : 'Edit Admin',
                style: const TextStyle(
                  color: navy,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: _inputDecoration(
                        'Nama Lengkap',
                        Icons.person_outline,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        'Email',
                        Icons.email_outlined,
                      ),
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      initialValue: selectedDivision,
                      decoration: _inputDecoration(
                        'Division',
                        Icons.business_outlined,
                      ),
                      items: divisions.map((division) {
                        return DropdownMenuItem<String>(
                          value: division.name,
                          child: Text(division.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedDivision = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: textGrey,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    final name =
                        nameController.text.trim();

                    final email =
                        emailController.text.trim();

                    if (name.isEmpty ||
                        email.isEmpty ||
                        selectedDivision == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Lengkapi semua data terlebih dahulu.',
                          ),
                        ),
                      );
                      return;
                    }

                    if (admin == null) {
                      widget.viewModel.addAdmin(
                        name: name,
                        email: email,
                        division: selectedDivision!,
                      );
                    } else {
                      widget.viewModel.updateAdmin(
                        admin: admin,
                        name: name,
                        email: email,
                        division: selectedDivision!,
                      );
                    }

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          admin == null
                              ? 'Akun admin berhasil ditambahkan.'
                              : 'Data admin berhasil diperbarui.',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    admin == null
                        ? 'Add Admin'
                        : 'Save Changes',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // TOGGLE STATUS
  // ============================================================

  void toggleStatus(AdminUser admin) {
    widget.viewModel.toggleAdminStatus(admin);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          admin.isActive
              ? '${admin.name} berhasil diaktifkan.'
              : '${admin.name} berhasil dinonaktifkan.',
        ),
      ),
    );
  }

  // ============================================================
  // DELETE
  // ============================================================

  void deleteAdmin(AdminUser admin) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Admin'),
          content: Text(
            'Apakah kamu yakin ingin menghapus akun '
            '${admin.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                widget.viewModel.deleteAdmin(admin);

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Akun admin berhasil dihapus.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // INPUT
  // ============================================================

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: border,
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
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

            _buildTable(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'User Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),

              SizedBox(height: 8),

              Text(
                'Kelola akun admin dan status pengguna.',
                style: TextStyle(
                  fontSize: 15,
                  color: textGrey,
                ),
              ),
            ],
          ),
        ),

        ElevatedButton.icon(
          onPressed: () {
            if (widget.viewModel.divisions.isEmpty) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'Tambahkan division terlebih dahulu.',
                  ),
                ),
              );
              return;
            }

            showAdminForm();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Admin'),
          style: ElevatedButton.styleFrom(
            backgroundColor: navy,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TABLE
  // ============================================================

  Widget _buildTable() {
    final admins = widget.viewModel.admins;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: border,
        ),
      ),
      child: admins.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Text(
                  'Belum ada akun admin.',
                  style: TextStyle(
                    color: textGrey,
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(
                  background,
                ),
                columnSpacing: 35,
                horizontalMargin: 20,
                columns: const [
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('Division'),
                  ),
                  DataColumn(
                    label: Text('Status'),
                  ),
                  DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: admins.map((admin) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          admin.name,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.w600,
                            color: navy,
                          ),
                        ),
                      ),

                      DataCell(
                        Text(
                          admin.email,
                          style: const TextStyle(
                            color: textGrey,
                          ),
                        ),
                      ),

                      DataCell(
                        Text(admin.division),
                      ),

                      DataCell(
                        _statusBadge(admin),
                      ),

                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              tooltip: 'Edit',
                              onPressed: () {
                                showAdminForm(
                                  admin: admin,
                                );
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 19,
                              ),
                            ),

                            IconButton(
                              tooltip: admin.isActive
                                  ? 'Deactivate'
                                  : 'Activate',
                              onPressed: () {
                                toggleStatus(admin);
                              },
                              icon: Icon(
                                admin.isActive
                                    ? Icons
                                        .person_off_outlined
                                    : Icons
                                        .person_outline,
                                size: 19,
                              ),
                            ),

                            IconButton(
                              tooltip: 'Delete',
                              onPressed: () {
                                deleteAdmin(admin);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 19,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _statusBadge(AdminUser admin) {
    final color =
        admin.isActive ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        admin.isActive
            ? 'Active'
            : 'Inactive',
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}