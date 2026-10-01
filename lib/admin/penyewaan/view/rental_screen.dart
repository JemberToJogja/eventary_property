import 'package:flutter/material.dart';
import '../model/rental_model.dart';
import '../viewmodel/rental_viewmodel.dart';
import 'rental_detail.dart';
import 'rental_form.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  late final RentalViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RentalViewModel();
    viewModel.addListener(_refresh);
  }

  @override
  void dispose() {
    viewModel.removeListener(_refresh);
    viewModel.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void _openAddForm() {
    showDialog(
      context: context,
      builder: (_) => RentalForm(
        onSave: (rental) {
          viewModel.addRental(rental);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data penyewaan berhasil ditambahkan'),
            ),
          );
        },
      ),
    );
  }

  void _openEditForm(Rental rental) {
    showDialog(
      context: context,
      builder: (_) => RentalForm(
        rental: rental,
        onSave: (updatedRental) {
          viewModel.updateRental(updatedRental);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data penyewaan berhasil diperbarui'),
            ),
          );
        },
      ),
    );
  }

  void _deleteRental(Rental rental) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Penyewaan'),
          content: Text(
            'Apakah Anda yakin ingin menghapus data ${rental.id}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                viewModel.deleteRental(rental.id);
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data berhasil dihapus'),
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _openDetail(Rental rental) {
    showDialog(
      context: context,
      builder: (_) => RentalDetail(rental: rental),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth - 56,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 26),
                    _buildStatistics(),
                    const SizedBox(height: 26),
                    _buildToolbar(),
                    const SizedBox(height: 18),
                    _buildTable(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Penyewaan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Kelola pengajuan dan penggunaan properti.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        FilledButton.icon(
          onPressed: _openAddForm,
          icon: const Icon(Icons.add, size: 19),
          label: const Text('Tambah Penyewaan'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatistics() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _statCard(
          'Total Penyewaan',
          viewModel.totalRentals,
          Icons.assignment_outlined,
        ),
        _statCard(
          'Pending',
          viewModel.pendingCount,
          Icons.schedule_outlined,
        ),
        _statCard(
          'Disetujui',
          viewModel.approvedCount,
          Icons.check_circle_outline,
        ),
        _statCard(
          'Selesai',
          viewModel.completedCount,
          Icons.task_alt,
        ),
      ],
    );
  }

  Widget _statCard(
    String title,
    int value,
    IconData icon,
  ) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF374151),
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: viewModel.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Cari penyewa, perusahaan, atau properti...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 170,
            child: DropdownButtonFormField<String>(
              value: viewModel.selectedStatus,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
              items: viewModel.statusOptions
                  .map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  viewModel.setStatusFilter(value);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: viewModel.resetFilter,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reset'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final rentals = viewModel.filteredRentals;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: rentals.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Text(
                  'Tidak ada data penyewaan.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            )
          : LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
          ),
          child: DataTable(
            columnSpacing: 28,
            horizontalMargin: 20,
            headingRowHeight: 48,
            dataRowMinHeight: 62,
            dataRowMaxHeight: 70,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B5563),
              fontSize: 13,
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Penyewa')),
              DataColumn(label: Text('Properti')),
              DataColumn(label: Text('Periode')),
              DataColumn(label: Text('Keperluan')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Aksi')),
            ],
            rows: rentals.map(_buildRow).toList(),
          ),
        ),
      );
    },
  ),
    );
  }

  DataRow _buildRow(Rental rental) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            rental.id,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rental.tenantName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  rental.companyName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 130,
            child: Text(
              rental.propertyName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
        DataCell(
          Text(
            '${_formatDate(rental.startDate)}\n${_formatDate(rental.endDate)}',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        DataCell(
          SizedBox(
            width: 120,
            child: Text(
              rental.purpose,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
        DataCell(_statusBadge(rental.status)),
        DataCell(
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      _actionButton(
        icon: Icons.visibility_outlined,
        tooltip: 'Detail',
        onTap: () {
          _openDetail(rental);
        },
      ),

      _actionButton(
        icon: Icons.edit_outlined,
        tooltip: 'Edit',
        onTap: () {
          _openEditForm(rental);
        },
      ),

      _actionButton(
        icon: Icons.delete_outline_rounded,
        tooltip: 'Hapus',
        danger: true,
        onTap: () {
          _deleteRental(rental);
        },
      ),
    ],
  ),  
),
      ],
    );
  }

  Widget _statusBadge(String status) {
    Color background;
    Color text;

    switch (status) {
      case 'Approved':
        background = const Color(0xFFDCFCE7);
        text = const Color(0xFF166534);
        break;

      case 'Pending':
        background = const Color(0xFFFEF3C7);
        text = const Color(0xFF92400E);
        break;

      case 'Review':
        background = const Color(0xFFDBEAFE);
        text = const Color(0xFF1D4ED8);
        break;

      case 'Completed':
        background = const Color(0xFFE0E7FF);
        text = const Color(0xFF3730A3);
        break;

      case 'Rejected':
        background = const Color(0xFFFEE2E2);
        text = const Color(0xFF991B1B);
        break;

      case 'Cancelled':
        background = const Color(0xFFF3F4F6);
        text = const Color(0xFF4B5563);
        break;

      case 'Ongoing':
        background = const Color(0xFFE0F2FE);
        text = const Color(0xFF0369A1);
        break;

      default:
        background = const Color(0xFFF3F4F6);
        text = const Color(0xFF374151);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

 Widget _actionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            size: 17,
            color: danger
                ? const Color(0xFFDC4C4C)
                : const Color(0xFF687084),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}