import 'package:flutter/material.dart';

import '../model/event_model.dart';
import '../viewmodel/event_viewmodel.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final EventViewModel viewModel;

  static const Color primary = Color(0xFF6366F1);
  static const Color darkText = Color(0xFF172033);
  static const Color secondaryText = Color(0xFF697386);
  static const Color borderColor = Color(0xFFE5E7EF);
  static const Color pageBackground = Color(0xFFF7F8FC);

  @override
  void initState() {
    super.initState();
    viewModel = EventViewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        return Container(
          color: pageBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
          
              const SizedBox(height: 22),
          
              _buildSummaryCards(),
          
              const SizedBox(height: 22),
          
              Expanded(
                child: _buildMainCard(),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Event Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Kelola kegiatan, penggunaan properti, dan informasi event.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 20),

        ElevatedButton.icon(
          onPressed: _openAddForm,
          icon: const Icon(
            Icons.add_rounded,
            size: 20,
          ),
          label: const Text(
            'Tambah Event',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SUMMARY CARDS
  // ============================================================

  Widget _buildSummaryCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final cardWidth = width < 900
            ? (width - 14) / 2
            : (width - 42) / 4;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            SizedBox(
              width: cardWidth,
              child: _summaryCard(
                title: 'Total Event',
                value: viewModel.totalEvents,
                description: 'Semua kegiatan',
                icon: Icons.event_available_outlined,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _summaryCard(
                title: 'Scheduled',
                value: viewModel.scheduledEvents,
                description: 'Akan berlangsung',
                icon: Icons.calendar_month_outlined,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _summaryCard(
                title: 'Ongoing',
                value: viewModel.ongoingEvents,
                description: 'Sedang berlangsung',
                icon: Icons.timelapse_outlined,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _summaryCard(
                title: 'Completed',
                value: viewModel.completedEvents,
                description: 'Telah selesai',
                icon: Icons.task_alt_outlined,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _summaryCard({
    required String title,
    required int value,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primary,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MAIN CARD
  // ============================================================

  Widget _buildMainCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        children: [
          _buildToolbar(),

          const Divider(
            height: 1,
            color: Color(0xFFE9EAF0),
          ),

          Expanded(
            child: _buildEventTable(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOOLBAR
  // ============================================================

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: pageBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE0E3EA),
                ),
              ),
              child: TextField(
                onChanged: viewModel.search,
                decoration: InputDecoration(
                  hintText:
                      'Cari nama event, properti, penyelenggara, atau ID...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: 160,
            height: 44,
            child: DropdownButtonFormField<String>(
              initialValue: viewModel.selectedStatus,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Status',
                labelStyle: const TextStyle(
                  fontSize: 12,
                ),
                filled: true,
                fillColor: pageBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E3EA),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E3EA),
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Semua',
                  child: Text('Semua Status'),
                ),
                DropdownMenuItem(
                  value: 'Scheduled',
                  child: Text('Scheduled'),
                ),
                DropdownMenuItem(
                  value: 'Ongoing',
                  child: Text('Ongoing'),
                ),
                DropdownMenuItem(
                  value: 'Completed',
                  child: Text('Completed'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  viewModel.setStatus(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EVENT TABLE
  // ============================================================

  Widget _buildEventTable() {
    final events = viewModel.filteredEvents;

    if (events.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        _buildTableHeader(),

        const Divider(
          height: 1,
          color: Color(0xFFE9EAF0),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return _buildEventRow(
                events[index],
                index,
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TABLE HEADER
  // ============================================================

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 13,
      ),
      color: const Color(0xFFFAFAFC),
      child: Row(
        children: [
          const SizedBox(
            width: 34,
            child: Text(
              'NO',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            flex: 30,
            child: Text(
              'EVENT',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),

          const Expanded(
            flex: 20,
            child: Text(
              'PROPERTI',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),

          const Expanded(
            flex: 21,
            child: Text(
              'PERIODE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),

          const Expanded(
            flex: 22,
            child: Text(
              'PENYELENGGARA',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),

          const SizedBox(
            width: 92,
            child: Text(
              'STATUS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),

          const SizedBox(
            width: 88,
            child: Text(
              'AKSI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EVENT ROW
  // ============================================================

  Widget _buildEventRow(
    Event event,
    int index,
  ) {
    return InkWell(
      onTap: () => _showDetail(event),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE9EAF0),
            ),
          ),
        ),
        child: Row(
          children: [
            // NO
            SizedBox(
              width: 34,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // EVENT
            Expanded(
              flex: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${event.id} • ${event.type}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            // PROPERTY
            Expanded(
              flex: 20,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Text(
                  event.propertyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF30384A),
                  ),
                ),
              ),
            ),

            // PERIOD
            Expanded(
              flex: 21,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Text(
                  _formatDateRange(
                    event.startDate,
                    event.endDate,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),

            // ORGANIZER
            Expanded(
              flex: 22,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Text(
                  event.organizer,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF30384A),
                  ),
                ),
              ),
            ),

            // STATUS
            SizedBox(
              width: 92,
              child: Align(
                alignment: Alignment.centerLeft,
                child: _statusBadge(event.status),
              ),
            ),

            // ACTION
            SizedBox(
              width: 88,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    icon: Icons.visibility_outlined,
                    tooltip: 'Detail',
                    onTap: () {
                      _showDetail(event);
                    },
                  ),

                  _actionButton(
                    icon: Icons.edit_outlined,
                    tooltip: 'Edit',
                    onTap: () {
                      _openEditForm(event);
                    },
                  ),

                  _actionButton(
                    icon: Icons.delete_outline_rounded,
                    tooltip: 'Hapus',
                    danger: true,
                    onTap: () {
                      _confirmDelete(event);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================

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

  // ============================================================
  // STATUS
  // ============================================================

  Widget _statusBadge(String status) {
    Color textColor;
    Color backgroundColor;

    switch (status) {
      case 'Scheduled':
        textColor = const Color(0xFF2563EB);
        backgroundColor = const Color(0xFFEFF6FF);
        break;

      case 'Ongoing':
        textColor = const Color(0xFFD97706);
        backgroundColor = const Color(0xFFFFF7ED);
        break;

      case 'Completed':
        textColor = const Color(0xFF16A34A);
        backgroundColor = const Color(0xFFF0FDF4);
        break;

      default:
        textColor = Colors.grey.shade700;
        backgroundColor = Colors.grey.shade100;
    }

    return Container(
      constraints: const BoxConstraints(
        minWidth: 72,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ============================================================
  // ADD
  // ============================================================

  void _openAddForm() {
    _showEventForm();
  }

  // ============================================================
  // EDIT
  // ============================================================

  void _openEditForm(Event event) {
    _showEventForm(
      event: event,
    );
  }

  // ============================================================
  // EVENT FORM
  // ============================================================

  void _showEventForm({
    Event? event,
  }) {
    final isEdit = event != null;

    final nameController = TextEditingController(
      text: event?.name ?? '',
    );

    final organizerController = TextEditingController(
      text: event?.organizer ?? '',
    );

    final picController = TextEditingController(
      text: event?.pic ?? '',
    );

    final descriptionController = TextEditingController(
      text: event?.description ?? '',
    );

    String selectedType = event?.type ?? 'Exhibition';

    String selectedStatus = event?.status ?? 'Scheduled';

    String selectedProperty = event?.propertyName ?? 'Mall ABC';

    DateTime startDate =
        event?.startDate ?? DateTime.now();

    DateTime endDate =
        event?.endDate ??
        DateTime.now().add(
          const Duration(days: 1),
        );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 680,
                constraints: const BoxConstraints(
                  maxHeight: 760,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _formHeader(
                      dialogContext,
                      isEdit,
                    ),

                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          24,
                          20,
                          24,
                          10,
                        ),
                        child: Column(
                          children: [
                            _formSection(
                              title: 'Informasi Event',
                              child: Column(
                                children: [
                                  _textField(
                                    controller: nameController,
                                    label: 'Nama Event',
                                    hint: 'Masukkan nama event',
                                  ),

                                  const SizedBox(height: 14),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: _dropdownField(
                                          label: 'Jenis Event',
                                          value: selectedType,
                                          items: const [
                                            'Exhibition',
                                            'Festival',
                                            'Corporate',
                                            'Conference',
                                            'Seminar',
                                            'Other',
                                          ],
                                          onChanged: (value) {
                                            setDialogState(() {
                                              selectedType = value;
                                            });
                                          },
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: _dropdownField(
                                          label: 'Status',
                                          value: selectedStatus,
                                          items: const [
                                            'Scheduled',
                                            'Ongoing',
                                            'Completed',
                                          ],
                                          onChanged: (value) {
                                            setDialogState(() {
                                              selectedStatus = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 18),

                            _formSection(
                              title: 'Penggunaan Properti',
                              child: _dropdownField(
                                label: 'Properti yang Digunakan',
                                value: selectedProperty,
                                items: const [
                                  'Mall ABC',
                                  'Mall XYZ',
                                  'Event Venue A',
                                  'Convention Hall',
                                ],
                                onChanged: (value) {
                                  setDialogState(() {
                                    selectedProperty = value;
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 18),

                            _formSection(
                              title: 'Jadwal Event',
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _dateField(
                                      label: 'Tanggal Mulai',
                                      date: startDate,
                                      onTap: () async {
                                        final picked =
                                            await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2025),
                                          lastDate: DateTime(2035),
                                          initialDate: startDate,
                                        );

                                        if (picked != null) {
                                          setDialogState(() {
                                            startDate = picked;

                                            if (endDate.isBefore(
                                              startDate,
                                            )) {
                                              endDate = startDate;
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: _dateField(
                                      label: 'Tanggal Selesai',
                                      date: endDate,
                                      onTap: () async {
                                        final picked =
                                            await showDatePicker(
                                          context: context,
                                          firstDate: startDate,
                                          lastDate: DateTime(2035),
                                          initialDate: endDate,
                                        );

                                        if (picked != null) {
                                          setDialogState(() {
                                            endDate = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 18),

                            _formSection(
                              title: 'Penanggung Jawab',
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _textField(
                                      controller:
                                          organizerController,
                                      label: 'Penyelenggara',
                                      hint:
                                          'Nama perusahaan / organisasi',
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: _textField(
                                      controller: picController,
                                      label: 'PIC',
                                      hint:
                                          'Penanggung jawab event',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 18),

                            _formSection(
                              title: 'Deskripsi',
                              child: _textField(
                                controller:
                                    descriptionController,
                                label: 'Deskripsi Event',
                                hint:
                                    'Tuliskan informasi atau catatan event...',
                                maxLines: 4,
                              ),
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),

                    _formFooter(
                      dialogContext: dialogContext,
                      isEdit: isEdit,
                      nameController: nameController,
                      organizerController: organizerController,
                      picController: picController,
                      descriptionController:
                          descriptionController,
                      selectedType: selectedType,
                      selectedStatus: selectedStatus,
                      selectedProperty: selectedProperty,
                      startDate: startDate,
                      endDate: endDate,
                      event: event,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // FORM HEADER
  // ============================================================

  Widget _formHeader(
    BuildContext dialogContext,
    bool isEdit,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        24,
        20,
        18,
        18,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFBFBFE),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9EAF0),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit
                      ? 'Edit Event'
                      : 'Tambah Event Baru',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  isEdit
                      ? 'Perbarui informasi event.'
                      : 'Masukkan informasi kegiatan yang menggunakan properti.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Tutup',
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            icon: const Icon(
              Icons.close_rounded,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FORM SECTION
  // ============================================================

  Widget _formSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF30384A),
          ),
        ),

        const SizedBox(height: 9),

        child,
      ],
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
        filled: true,
        fillColor: const Color(0xFFF8F9FC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE1E4EC),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE1E4EC),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: primary,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8F9FC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE1E4EC),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE1E4EC),
          ),
        ),
      ),
      items: items.map(
        (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }

  // ============================================================
  // DATE FIELD
  // ============================================================

  Widget _dateField({
    required String label,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
            size: 18,
          ),
          filled: true,
          fillColor: const Color(0xFFF8F9FC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFE1E4EC),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFE1E4EC),
            ),
          ),
        ),
        child: Text(
          _formatDate(date),
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FORM FOOTER
  // ============================================================

  Widget _formFooter({
    required BuildContext dialogContext,
    required bool isEdit,
    required TextEditingController nameController,
    required TextEditingController organizerController,
    required TextEditingController picController,
    required TextEditingController descriptionController,
    required String selectedType,
    required String selectedStatus,
    required String selectedProperty,
    required DateTime startDate,
    required DateTime endDate,
    required Event? event,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        24,
        15,
        24,
        20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE9EAF0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF4B5563),
              side: const BorderSide(
                color: Color(0xFFD9DDE6),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: const Text('Batal'),
          ),

          const SizedBox(width: 10),

          ElevatedButton.icon(
            onPressed: () {
              _saveEvent(
                dialogContext: dialogContext,
                isEdit: isEdit,
                nameController: nameController,
                organizerController: organizerController,
                picController: picController,
                descriptionController:
                    descriptionController,
                selectedType: selectedType,
                selectedStatus: selectedStatus,
                selectedProperty: selectedProperty,
                startDate: startDate,
                endDate: endDate,
                event: event,
              );
            },
            icon: Icon(
              isEdit
                  ? Icons.save_outlined
                  : Icons.add_rounded,
              size: 18,
            ),
            label: Text(
              isEdit
                  ? 'Simpan Perubahan'
                  : 'Simpan Event',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SAVE EVENT
  // ============================================================

  void _saveEvent({
    required BuildContext dialogContext,
    required bool isEdit,
    required TextEditingController nameController,
    required TextEditingController organizerController,
    required TextEditingController picController,
    required TextEditingController descriptionController,
    required String selectedType,
    required String selectedStatus,
    required String selectedProperty,
    required DateTime startDate,
    required DateTime endDate,
    required Event? event,
  }) {
    if (nameController.text.trim().isEmpty) {
      _showMessage(
        'Nama event wajib diisi.',
        error: true,
      );
      return;
    }

    if (organizerController.text.trim().isEmpty) {
      _showMessage(
        'Nama penyelenggara wajib diisi.',
        error: true,
      );
      return;
    }

    if (endDate.isBefore(startDate)) {
      _showMessage(
        'Tanggal selesai tidak boleh sebelum tanggal mulai.',
        error: true,
      );
      return;
    }

    final newEvent = Event(
      id: isEdit
          ? event!.id
          : viewModel.generateId(),
      name: nameController.text.trim(),
      type: selectedType,
      propertyId: _propertyIdFromName(
        selectedProperty,
      ),
      propertyName: selectedProperty,
      startDate: startDate,
      endDate: endDate,
      organizer: organizerController.text.trim(),
      pic: picController.text.trim().isEmpty
          ? 'Belum ditentukan'
          : picController.text.trim(),
      status: selectedStatus,
      description: descriptionController.text.trim(),
    );

    if (isEdit) {
      viewModel.updateEvent(newEvent);
    } else {
      viewModel.addEvent(newEvent);
    }

    Navigator.pop(dialogContext);

    _showMessage(
      isEdit
          ? 'Event berhasil diperbarui.'
          : 'Event berhasil ditambahkan.',
    );
  }

  // ============================================================
  // DETAIL
  // ============================================================

  void _showDetail(Event event) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 600,
            constraints: const BoxConstraints(
              maxHeight: 700,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    20,
                    16,
                    18,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBFBFE),
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE9EAF0),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.id,
                              style: const TextStyle(
                                fontSize: 10,
                                color: primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              event.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        _detailItem(
                          label: 'Jenis Event',
                          value: event.type,
                        ),
                        _detailItem(
                          label: 'Properti',
                          value: event.propertyName,
                        ),
                        _detailItem(
                          label: 'Periode',
                          value: _formatDateRange(
                            event.startDate,
                            event.endDate,
                          ),
                        ),
                        _detailItem(
                          label: 'Penyelenggara',
                          value: event.organizer,
                        ),
                        _detailItem(
                          label: 'PIC',
                          value: event.pic,
                        ),
                        _detailItem(
                          label: 'Status',
                          value: event.status,
                        ),

                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: pageBackground,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Deskripsi',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                event.description.trim().isEmpty
                                    ? 'Tidak ada deskripsi.'
                                    : event.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFE9EAF0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          _openEditForm(event);
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 17,
                        ),
                        label: const Text('Edit'),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          _confirmDelete(event);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 17,
                        ),
                        label: const Text('Hapus'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFDC4C4C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // DETAIL ITEM
  // ============================================================

  Widget _detailItem({
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: pageBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF30384A),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DELETE
  // ============================================================

  void _confirmDelete(Event event) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Hapus Event?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Event "${event.name}" akan dihapus dari data prototype.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () {
                viewModel.deleteEvent(event.id);

                Navigator.pop(dialogContext);

                _showMessage(
                  'Event berhasil dihapus.',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFDC4C4C),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy_outlined,
            size: 42,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 14),

          const Text(
            'Event tidak ditemukan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF30384A),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Coba ubah kata pencarian atau filter.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton.icon(
            onPressed: _openAddForm,
            icon: const Icon(
              Icons.add,
              size: 17,
            ),
            label: const Text('Tambah Event'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROPERTY ID
  // ============================================================

  String _propertyIdFromName(
    String propertyName,
  ) {
    switch (propertyName) {
      case 'Mall ABC':
        return 'PROP-001';

      case 'Mall XYZ':
        return 'PROP-002';

      case 'Event Venue A':
        return 'PROP-003';

      case 'Convention Hall':
        return 'PROP-004';

      default:
        return 'PROP-001';
    }
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(
    DateTime date,
  ) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateRange(
    DateTime start,
    DateTime end,
  ) {
    return '${_formatDate(start)} - ${_formatDate(end)}';
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message, {
    bool error = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                error
                    ? Icons.error_outline
                    : Icons.check_circle_outline,
                color: Colors.white,
                size: 19,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(message),
              ),
            ],
          ),
          backgroundColor: error
              ? const Color(0xFFDC4C4C)
              : const Color(0xFF16A34A),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }
}