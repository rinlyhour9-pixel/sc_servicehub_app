import 'technician_profile.dart';

enum AdminBookingStage { pending, inProgress, complete }

/// A booking as the admin sees it — mutable so assigning a technician or
/// advancing its stage is visible everywhere it's shown (Total Booking,
/// Track Booking, Today's Schedule, Customer Profile history, dashboard counts).
class AdminBookingEntry {
  final String id;
  final String customer;
  final String service;
  final String dateTime;
  AdminBookingStage stage;
  TechnicianProfile? technician;
  DateTime? assignedAt;

  AdminBookingEntry({
    required this.id,
    required this.customer,
    required this.service,
    required this.dateTime,
    required this.stage,
    this.technician,
    this.assignedAt,
  });
}
