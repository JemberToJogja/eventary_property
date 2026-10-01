import 'package:flutter/foundation.dart';

import '../../../data/dummy_rentals.dart';
import '../model/rental_model.dart';

class RentalViewModel extends ChangeNotifier {
  final List<Rental> _rentals = List.from(dummyRentals);

  String _searchQuery = '';
  String _selectedStatus = 'Semua';

  List<Rental> get rentals => List.unmodifiable(_rentals);

  String get searchQuery => _searchQuery;

  String get selectedStatus => _selectedStatus;

  // =========================
  // FILTER DATA
  // =========================

  List<Rental> get filteredRentals {
    return _rentals.where((rental) {
      final query = _searchQuery.toLowerCase().trim();

      final matchesSearch =
          query.isEmpty ||
          rental.id.toLowerCase().contains(query) ||
          rental.tenantName.toLowerCase().contains(query) ||
          rental.companyName.toLowerCase().contains(query) ||
          rental.propertyName.toLowerCase().contains(query) ||
          rental.purpose.toLowerCase().contains(query);

      final matchesStatus =
          _selectedStatus == 'Semua' ||
          rental.status == _selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  // =========================
  // SEARCH
  // =========================

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  // =========================
  // FILTER STATUS
  // =========================

  void setStatusFilter(String status) {
    _selectedStatus = status;
    notifyListeners();
  }

  // =========================
  // STATUS LIST
  // =========================

  List<String> get statusOptions {
    return [
      'Semua',
      'Pending',
      'Review',
      'Approved',
      'Ongoing',
      'Completed',
      'Rejected',
      'Cancelled',
    ];
  }

  // =========================
  // TAMBAH DATA
  // =========================

  void addRental(Rental rental) {
    _rentals.add(rental);
    notifyListeners();
  }

  // =========================
  // EDIT DATA
  // =========================

  void updateRental(Rental updatedRental) {
    final index = _rentals.indexWhere(
      (rental) => rental.id == updatedRental.id,
    );

    if (index == -1) return;

    _rentals[index] = updatedRental;

    notifyListeners();
  }

  // =========================
  // HAPUS DATA
  // =========================

  void deleteRental(String id) {
    _rentals.removeWhere(
      (rental) => rental.id == id,
    );

    notifyListeners();
  }

  // =========================
  // CARI DATA BERDASARKAN ID
  // =========================

  Rental? getRentalById(String id) {
    try {
      return _rentals.firstWhere(
        (rental) => rental.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  // =========================
  // STATISTIK
  // =========================

  int get totalRentals {
    return _rentals.length;
  }

  int get pendingCount {
    return _countByStatus('Pending');
  }

  int get reviewCount {
    return _countByStatus('Review');
  }

  int get approvedCount {
    return _countByStatus('Approved');
  }

  int get ongoingCount {
    return _countByStatus('Ongoing');
  }

  int get completedCount {
    return _countByStatus('Completed');
  }

  int get rejectedCount {
    return _countByStatus('Rejected');
  }

  int get cancelledCount {
    return _countByStatus('Cancelled');
  }

  int _countByStatus(String status) {
    return _rentals.where(
      (rental) => rental.status == status,
    ).length;
  }

  // =========================
  // RESET FILTER
  // =========================

  void resetFilter() {
    _searchQuery = '';
    _selectedStatus = 'Semua';

    notifyListeners();
  }
}