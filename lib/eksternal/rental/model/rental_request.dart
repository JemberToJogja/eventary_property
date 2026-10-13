import '../../../admin/models/property.dart';

class RentalRequest {
  final String id;
  final Property property;

  final String rentalPurpose;
  final DateTime startDate;
  final DateTime endDate;

  final String fullName;
  final String company;
  final String email;
  final String phone;

  final int? guestCount;
  final String notes;

  final String status;
  final DateTime createdAt;

  RentalRequest({
    required this.id,
    required this.property,
    required this.rentalPurpose,
    required this.startDate,
    required this.endDate,
    required this.fullName,
    required this.company,
    required this.email,
    required this.phone,
    this.guestCount,
    required this.notes,
    this.status = 'Pending',
    required this.createdAt,
  });
}