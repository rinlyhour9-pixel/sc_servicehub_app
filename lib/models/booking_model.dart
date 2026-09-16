enum BookingStatus { pending, accepted, inProgress, completed, cancelled }

/// One step in the "Booking Status" timeline shown on BookingDetailScreen
/// (Booking Confirmed -> Technician Assigned -> Service in Process -> Service Complete).
class BookingStatusStep {
  final String label;
  final String? timestamp; // null while pending, filled once reached
  final bool isDone;
  final bool isCurrent;

  const BookingStatusStep({
    required this.label,
    this.timestamp,
    this.isDone = false,
    this.isCurrent = false,
  });
}

class Booking {
  final String id; // e.g. BR-240521-1287
  final String serviceName; // e.g. "AC Repair"
  final String iconAsset; // path to category icon/image
  final DateTime dateTime;
  final String address;
  final double? latitude; // pinned location, set when the client chooses one on the map
  final double? longitude;
  final String? description; // problem description entered on the form
  final List<String> photoUrls; // uploaded photos
  final BookingStatus status;
  final String? technicianName;
  final String? technicianPhone;
  final String? technicianAvatar;
  final List<BookingStatusStep> timeline;

  const Booking({
    required this.id,
    required this.serviceName,
    required this.iconAsset,
    required this.dateTime,
    required this.address,
    this.latitude,
    this.longitude,
    this.description,
    this.photoUrls = const [],
    required this.status,
    this.technicianName,
    this.technicianPhone,
    this.technicianAvatar,
    this.timeline = const [],
  });
}
