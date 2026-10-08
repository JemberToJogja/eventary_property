import 'package:flutter/material.dart';

import '../model/division.dart';
import '../viewmodel/super_admin_viewmodel.dart';

class DivisionManagementScreen extends StatefulWidget {
  const DivisionManagementScreen({
    super.key,
    required this.viewModel,
  });

  final SuperAdminViewModel viewModel;

  @override
  State<DivisionManagementScreen> createState() =>
      _DivisionManagementScreenState();
}

class _DivisionManagementScreenState
    extends State<DivisionManagementScreen> {
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
  // ADD / EDIT DIVISION
  // ============================================================

  void showDivisionForm({Division? division}) {
    final controller = TextEditingController(
      text: division?.name ?? '',
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            division == null
                ? 'Add Division'
                : 'Edit Division',
            style: const TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 400,
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Nama Division',
                prefixIcon: const Icon(
                  Icons.account_tree_outlined,
                ),
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
              ),
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
                final name = controller.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Nama division tidak boleh kosong.',
                      ),
                    ),
                  );
                  return;
                }

                if (division == null) {
                  widget.viewModel.addDivision(name);
                } else {
                  widget.viewModel.updateDivision(
                    division: division,
                    name: name,
                  );
                }

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      division == null
                          ? 'Division berhasil ditambahkan.'
                          : 'Division berhasil diperbarui.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                foregroundColor: Colors.white,
              ),
              child: Text(
                division == null
                    ? 'Add Division'
                    : 'Save Changes',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // DELETE DIVISION
  // ============================================================

  void deleteDivision(Division division) {
    // Cek apakah division masih digunakan oleh admin.
    final isUsed = widget.viewModel.admins.any(
      (admin) => admin.division == division.name,
    );

    if (isUsed) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Division Tidak Dapat Dihapus'),
            content: Text(
              'Division "${division.name}" masih digunakan '
              'oleh salah satu atau beberapa akun admin.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Division'),
          content: Text(
            'Apakah kamu yakin ingin menghapus '
            'division "${division.name}"?',
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
                widget.viewModel.deleteDivision(division);

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Division berhasil dihapus.',
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
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Division Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Kelola division yang digunakan oleh akun admin.',
                style: TextStyle(
                  fontSize: 15,
                  color: textGrey,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => showDivisionForm(),
          icon: const Icon(Icons.add),
          label: const Text('Add Division'),
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
    final divisions = widget.viewModel.divisions;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: border,
        ),
      ),
      child: divisions.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Text(
                  'Belum ada division.',
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
                columnSpacing: 40,
                horizontalMargin: 20,
                columns: const [
                  DataColumn(
                    label: Text('No'),
                  ),
                  DataColumn(
                    label: Text('Division'),
                  ),
                  DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: List.generate(
                  divisions.length,
                  (index) {
                    final division = divisions[index];

                    return DataRow(
                      cells: [
                        DataCell(
                          Text('${index + 1}'),
                        ),
                        DataCell(
                          Text(
                            division.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: navy,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                onPressed: () {
                                  showDivisionForm(
                                    division: division,
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 19,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                onPressed: () {
                                  deleteDivision(division);
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
                  },
                ),
              ),
            ),
    );
  }
}