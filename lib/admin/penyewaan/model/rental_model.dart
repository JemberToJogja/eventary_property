class Rental {
  final String id;
  final String tenantName;
  final String companyName;
  final String contact;
  final String propertyId;
  final String propertyName;
  final DateTime startDate;
  final DateTime endDate;
  final String purpose;
  final int numberOfGuests;
  final String pic;
  final String status;
  final String notes;
  final DateTime createdAt;

  Rental({
    required this.id,
    required this.tenantName,
    required this.companyName,
    required this.contact,
    required this.propertyId,
    required this.propertyName,
    required this.startDate,
    required this.endDate,
    required this.purpose,
    required this.numberOfGuests,
    required this.pic,
    required this.status,
    required this.notes,
    required this.createdAt,
  });

  Rental copyWith({
    String? id,
    String? tenantName,
    String? companyName,
    String? contact,
    String? propertyId,
    String? propertyName,
    DateTime? startDate,
    DateTime? endDate,
    String? purpose,
    int? numberOfGuests,
    String? pic,
    String? status,
    String? notes,
    DateTime? createdAt,
  }) {
    return Rental(
      id: id ?? this.id,
      tenantName: tenantName ?? this.tenantName,
      companyName: companyName ?? this.companyName,
      contact: contact ?? this.contact,
      propertyId: propertyId ?? this.propertyId,
      propertyName: propertyName ?? this.propertyName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      purpose: purpose ?? this.purpose,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      pic: pic ?? this.pic,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}