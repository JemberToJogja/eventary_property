import 'package:flutter/material.dart';
import '../model/rental_model.dart';

class RentalForm extends StatefulWidget {
  final Rental? rental;
  final Function(Rental rental) onSave;

  const RentalForm({
    super.key,
    this.rental,
    required this.onSave,
  });

  bool get isEdit => rental != null;

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController tenantController;
  late final TextEditingController companyController;
  late final TextEditingController contactController;
  late final TextEditingController propertyIdController;
  late final TextEditingController propertyNameController;
  late final TextEditingController purposeController;
  late final TextEditingController guestsController;
  late final TextEditingController picController;
  late final TextEditingController notesController;

  DateTime? startDate;
  DateTime? endDate;
  String status = 'Pending';

  @override
  void initState() {
    super.initState();

    final rental = widget.rental;

    tenantController = TextEditingController(
      text: rental?.tenantName ?? '',
    );

    companyController = TextEditingController(
      text: rental?.companyName ?? '',
    );

    contactController = TextEditingController(
      text: rental?.contact ?? '',
    );

    propertyIdController = TextEditingController(
      text: rental?.propertyId ?? '',
    );

    propertyNameController = TextEditingController(
      text: rental?.propertyName ?? '',
    );

    purposeController = TextEditingController(
      text: rental?.purpose ?? '',
    );

    guestsController = TextEditingController(
      text: rental?.numberOfGuests.toString() ?? '',
    );

    picController = TextEditingController(
      text: rental?.pic ?? '',
    );

    notesController = TextEditingController(
      text: rental?.notes ?? '',
    );

    startDate = rental?.startDate;
    endDate = rental?.endDate;
    status = rental?.status ?? 'Pending';
  }

  @override
  void dispose() {
    tenantController.dispose();
    companyController.dispose();
    contactController.dispose();
    propertyIdController.dispose();
    propertyNameController.dispose();
    purposeController.dispose();
    guestsController.dispose();
    picController.dispose();
    notesController.dispose();

    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      setState(() {
        startDate = date;

        if (endDate != null && endDate!.isBefore(date)) {
          endDate = null;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: endDate ?? startDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      setState(() {
        endDate = date;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal mulai dan selesai harus dipilih.'),
        ),
      );
      return;
    }

    final rental = Rental(
      id: widget.rental?.id ??
          'RENT-${DateTime.now().millisecondsSinceEpoch}',
      tenantName: tenantController.text.trim(),
      companyName: companyController.text.trim(),
      contact: contactController.text.trim(),
      propertyId: propertyIdController.text.trim(),
      propertyName: propertyNameController.text.trim(),
      startDate: startDate!,
      endDate: endDate!,
      purpose: purposeController.text.trim(),
      numberOfGuests: int.parse(
        guestsController.text.trim(),
      ),
      pic: picController.text.trim(),
      status: status,
      notes: notesController.text.trim(),
      createdAt: widget.rental?.createdAt ?? DateTime.now(),
    );

    widget.onSave(rental);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 760,
          maxHeight: 850,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 28),

                _sectionTitle(
                  'Informasi Penyewa',
                  'Data pihak yang mengajukan penyewaan',
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _textField(
                        controller: tenantController,
                        label: 'Nama Penyewa',
                        hint: 'Masukkan nama penyewa',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _textField(
                        controller: companyController,
                        label: 'Nama Perusahaan',
                        hint: 'Masukkan nama perusahaan',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _textField(
                  controller: contactController,
                  label: 'Kontak',
                  hint: 'Nomor telepon / WhatsApp',
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 28),

                _sectionTitle(
                  'Informasi Properti',
                  'Properti yang akan digunakan',
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _textField(
                        controller: propertyIdController,
                        label: 'Property ID',
                        hint: 'Contoh: PROP-001',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _textField(
                        controller: propertyNameController,
                        label: 'Nama Properti',
                        hint: 'Contoh: Mall ABC',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                _sectionTitle(
                  'Detail Penyewaan',
                  'Informasi penggunaan properti',
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _dateField(
                        label: 'Tanggal Mulai',
                        value: startDate,
                        onTap: _selectStartDate,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _dateField(
                        label: 'Tanggal Selesai',
                        value: endDate,
                        onTap: _selectEndDate,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _textField(
                        controller: purposeController,
                        label: 'Keperluan',
                        hint: 'Contoh: Exhibition',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _textField(
                        controller: guestsController,
                        label: 'Jumlah Peserta',
                        hint: 'Contoh: 500',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _textField(
                        controller: picController,
                        label: 'PIC',
                        hint: 'Nama PIC',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: status,
                        decoration: _inputDecoration(
                          'Status',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Pending',
                            child: Text('Pending'),
                          ),
                          DropdownMenuItem(
                            value: 'Review',
                            child: Text('Review'),
                          ),
                          DropdownMenuItem(
                            value: 'Approved',
                            child: Text('Approved'),
                          ),
                          DropdownMenuItem(
                            value: 'Ongoing',
                            child: Text('Ongoing'),
                          ),
                          DropdownMenuItem(
                            value: 'Completed',
                            child: Text('Completed'),
                          ),
                          DropdownMenuItem(
                            value: 'Rejected',
                            child: Text('Rejected'),
                          ),
                          DropdownMenuItem(
                            value: 'Cancelled',
                            child: Text('Cancelled'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              status = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _textField(
                  controller: notesController,
                  label: 'Catatan',
                  hint: 'Tambahkan catatan jika diperlukan...',
                  maxLines: 4,
                  required: false,
                ),

                const SizedBox(height: 30),

                _buildActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.business_center_outlined,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEdit
                    ? 'Edit Penyewaan'
                    : 'Tambah Penyewaan',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.isEdit
                    ? 'Perbarui informasi penyewaan.'
                    : 'Tambahkan pengajuan penyewaan baru.',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: required
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label wajib diisi';
              }

              if (label == 'Jumlah Peserta') {
                if (int.tryParse(value.trim()) == null) {
                  return 'Masukkan angka yang valid';
                }
              }

              return null;
            }
          : null,
      decoration: _inputDecoration(label).copyWith(
        hintText: hint,
      ),
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: _inputDecoration(label),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Color(0xFF6B7280),
            ),
            const SizedBox(width: 10),
            Text(
              value == null
                  ? 'Pilih tanggal'
                  : _formatDate(value),
              style: TextStyle(
                fontSize: 14,
                color: value == null
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF374151),
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Batal'),
        ),
        const SizedBox(width: 12),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            widget.isEdit ? 'Simpan Perubahan' : 'Simpan Penyewaan',
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}