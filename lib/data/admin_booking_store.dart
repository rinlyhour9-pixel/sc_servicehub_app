import 'package:flutter/foundation.dart';

import '../models/admin_booking_entry.dart';
import '../models/technician_profile.dart';

/// Single shared source of truth for every booking the admin screens show.
/// Total Booking, Track Booking, Today's Schedule, Customer Profile history,
/// and the dashboard's stat counts all read (and, for Track Booking, write)
/// through this one store so an action taken in one screen is reflected
/// everywhere else instead of each screen owning its own disconnected copy.
class AdminBookingStore extends ChangeNotifier {
  AdminBookingStore._internal();
  static final AdminBookingStore instance = AdminBookingStore._internal();

  // TODO: replace with data from your admin/reporting API.
  final List<AdminBookingEntry> bookings = [
    AdminBookingEntry(
      id: '#BK240520001',
      customer: 'Jonh Smith',
      service: 'AC Service Repair',
      dateTime: '20 May 2026, 09:15 AM',
      stage: AdminBookingStage.pending,
    ),
    AdminBookingEntry(
      id: '#BK240520002',
      customer: 'Mary Janeeeee',
      service: 'Washing Machine Repair',
      dateTime: '20 May 2026, 09:15 AM',
      stage: AdminBookingStage.inProgress,
      technician: TechnicianProfile.demoDirectory[1],
      assignedAt: DateTime(2026, 5, 20, 4, 30),
    ),
    AdminBookingEntry(
      id: '#BK240520003',
      customer: 'Mary Janeeeee',
      service: 'TV Repair',
      dateTime: '20 May 2026, 09:15 AM',
      stage: AdminBookingStage.complete,
      technician: TechnicianProfile.demoDirectory[1],
      assignedAt: DateTime(2026, 5, 20, 4, 30),
    ),
    AdminBookingEntry(
      id: '#BK240520004',
      customer: 'Jonh Smith',
      service: 'AC Service Repair',
      dateTime: '20 May 2026, 09:15 AM',
      stage: AdminBookingStage.pending,
    ),
    AdminBookingEntry(
      id: '#BK240520005',
      customer: 'Mary Janeeeee',
      service: 'Washing Machine Repair',
      dateTime: '20 May 2026, 09:15 AM',
      stage: AdminBookingStage.inProgress,
      technician: TechnicianProfile.demoDirectory[0],
      assignedAt: DateTime(2026, 5, 20, 4, 30),
    ),
    AdminBookingEntry(
      id: '#BK240520006',
      customer: 'Mary Janeeeee',
      service: 'TV Repair',
      dateTime: '20 May 2026, 09:15 AM',
      stage: AdminBookingStage.complete,
      technician: TechnicianProfile.demoDirectory[0],
      assignedAt: DateTime(2026, 5, 20, 4, 30),
    ),
    AdminBookingEntry(
      id: '#BK240039',
      customer: 'Nam Jungouk',
      service: 'AC Repair',
      dateTime: '21 May 2026, 10:00 AM',
      stage: AdminBookingStage.pending,
    ),
    AdminBookingEntry(
      id: '#BK240040',
      customer: 'Steve Roger',
      service: 'Washing Machine',
      dateTime: '21 May 2026, 01:00 PM',
      stage: AdminBookingStage.inProgress,
      technician: TechnicianProfile.demoDirectory[2],
      assignedAt: DateTime(2026, 5, 21, 1, 30),
    ),
    AdminBookingEntry(
      id: '#BK240041',
      customer: 'Steve Roger',
      service: 'TV Repair',
      dateTime: '19 May 2026, 01:00 PM',
      stage: AdminBookingStage.complete,
      technician: TechnicianProfile.demoDirectory[2],
      assignedAt: DateTime(2026, 5, 19, 1, 30),
    ),
  ];

  AdminBookingEntry byId(String id) => bookings.firstWhere((b) => b.id == id);

  List<AdminBookingEntry> forCustomer(String customer) =>
      bookings.where((b) => b.customer == customer).toList();

  int countByStage(AdminBookingStage stage) =>
      bookings.where((b) => b.stage == stage).length;

  int get customerCount => bookings.map((b) => b.customer).toSet().length;

  void assignTechnician(String bookingId, TechnicianProfile technician) {
    byId(bookingId)
      ..technician = technician
      ..assignedAt = DateTime.now();
    notifyListeners();
  }
}
