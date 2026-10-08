import 'package:flutter/material.dart';

import '../../home/model/external_property.dart';
import '../../property/data/dummy_external_properties.dart';

class RequestRentalScreen extends StatefulWidget {
  const RequestRentalScreen({
    super.key,
    this.property,
    this.showNavbar = false,
    this.onBack,
  });

  final ExternalProperty? property;
  final bool showNavbar;
  final VoidCallback? onBack;

  @override
  State<RequestRentalScreen> createState() =>
      _RequestRentalScreenState();
}

class _RequestRentalScreenState
    extends State<RequestRentalScreen> {
  ExternalProperty? selectedProperty;

  DateTime? startDate;
  DateTime? endDate;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final purposeController = TextEditingController();

  static const navy = Color(0xFF172033);
  static const gold = Color(0xFFC09B60);
  static const bg = Color(0xFFF7F7F5);
  static const grey = Color(0xFF6F747C);

  @override
  void initState() {
    super.initState();
    selectedProperty = widget.property;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  Future<void> pickDate(bool isStart) async {
    final now = DateTime.now();

    final firstDate = isStart
        ? DateTime(now.year, now.month, now.day)
        : (startDate ?? now);

    final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: DateTime(now.year + 2),
      initialDate: firstDate,
    );

    if (date == null) return;

    setState(() {
      if (isStart) {
        startDate = date;

        if (endDate != null && endDate!.isBefore(date)) {
          endDate = null;
        }
      } else {
        endDate = date;
      }
    });
  }

  String dateText(DateTime? date) {
    if (date == null) return 'Pilih tanggal';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  InputDecoration input(
    String label,
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        size: 19,
        color: grey,
      ),
      filled: true,
      fillColor: const Color(0xFFFAFAF9),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: gold,
          width: 1.4,
        ),
      ),
    );
  }

  void submit() {
    if (selectedProperty == null ||
        startDate == null ||
        endDate == null ||
        nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        purposeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi data terlebih dahulu.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Request Berhasil'),
        content: const Text(
          'Permintaan rental berhasil dikirim.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onBack?.call();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: gold),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget dateCard(
    String title,
    DateTime? date,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAF9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: gold.withOpacity(.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: gold,
                  size: 19,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: grey,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateText(date),
                    style: const TextStyle(
                      color: navy,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget propertyCard() {
    if (selectedProperty == null) {
      return DropdownButtonFormField<ExternalProperty>(
        initialValue: selectedProperty,
        decoration: input(
          'Property',
          'Pilih property',
          Icons.business_outlined,
        ),
        items: dummyExternalProperties.map((property) {
          return DropdownMenuItem(
            value: property,
            child: Text(property.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedProperty = value;
          });
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAF9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.business_outlined,
              color: gold,
              size: 26,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  selectedProperty!.name,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  selectedProperty!.location,
                  style: const TextStyle(
                    color: grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: gold,
            size: 21,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              color: navy,
              padding: const EdgeInsets.symmetric(
                horizontal: 70,
                vertical: 42,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 1100),
                  child: Row(
                    children: [
                      if (widget.onBack != null)
                        IconButton(
                          onPressed: widget.onBack,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      if (widget.onBack != null)
                        const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REQUEST RENTAL',
                            style: TextStyle(
                              color: gold,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Request a Property',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Tell us what space you need for your next event.',
                            style: TextStyle(
                              color: Color(0xFFADB5C1),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CONTENT
            Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 45,
                    horizontal: 25,
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // FORM
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(.04),
                                blurRadius: 20,
                                offset:
                                    const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              sectionTitle(
                                'Property',
                                'Select the property you want to rent.',
                              ),

                              const SizedBox(height: 18),

                              propertyCard(),

                              const SizedBox(height: 35),

                              sectionTitle(
                                'Your Information',
                                'Provide your contact details.',
                              ),

                              const SizedBox(height: 18),

                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          nameController,
                                      decoration: input(
                                        'Nama Lengkap',
                                        'Masukkan nama',
                                        Icons.person_outline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          emailController,
                                      decoration: input(
                                        'Email',
                                        'nama@email.com',
                                        Icons.email_outlined,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          phoneController,
                                      decoration: input(
                                        'Nomor Telepon',
                                        '08xxxxxxxxxx',
                                        Icons.phone_outlined,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          purposeController,
                                      decoration: input(
                                        'Keperluan',
                                        'Contoh: Event',
                                        Icons.event_note_outlined,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 35),

                              sectionTitle(
                                'Rental Schedule',
                                'Choose your rental period.',
                              ),

                              const SizedBox(height: 18),

                              Row(
                                children: [
                                  dateCard(
                                    'Tanggal Mulai',
                                    startDate,
                                    () => pickDate(true),
                                  ),
                                  const SizedBox(width: 15),
                                  dateCard(
                                    'Tanggal Selesai',
                                    endDate,
                                    () => pickDate(false),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: gold,
                                    foregroundColor:
                                        Colors.white,
                                    elevation: 0,
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                        8,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit Rental Request',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 25),

                      // SIDE INFO
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: navy,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: gold,
                                size: 28,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Rental Information',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Submit your rental request and our team will review your requirements.',
                                style: TextStyle(
                                  color:
                                      Color(0xFFADB5C1),
                                  fontSize: 13,
                                  height: 1.7,
                                ),
                              ),
                              SizedBox(height: 25),
                              Text(
                                'What happens next?',
                                style: TextStyle(
                                  color: gold,
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                '01   Request submitted\n\n'
                                '02   Request reviewed\n\n'
                                '03   Admin contacts you\n\n'
                                '04   Rental confirmed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}