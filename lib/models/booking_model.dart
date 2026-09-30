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
  final double? latitude; // Retained for bundled sample bookings.
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

  factory Booking.fromApiJson(Map<String, dynamic> json) {
    final rawStatus = json['status']?.toString() ?? 'pending';
    final status = switch (rawStatus) {
      'assigned' => BookingStatus.accepted,
      'in_progress' => BookingStatus.inProgress,
      'completed' => BookingStatus.completed,
      'cancelled' => BookingStatus.cancelled,
      _ => BookingStatus.pending,
    };
    final service = json['service'] is Map
        ? Map<String, dynamic>.from(json['service'] as Map)
        : const <String, dynamic>{};
    final technician = json['technician'] is Map
        ? Map<String, dynamic>.from(json['technician'] as Map)
        : const <String, dynamic>{};
    final scheduledAt =
        DateTime.tryParse(json['scheduled_at']?.toString() ?? '') ??
            DateTime.now();
    final startedAt = json['started_at']?.toString();
    final completedAt = json['completed_at']?.toString();
    final reached = switch (status) {
      BookingStatus.pending => 0,
      BookingStatus.accepted => 1,
      BookingStatus.inProgress => 2,
      BookingStatus.completed => 3,
      BookingStatus.cancelled => 0,
    };
    const labels = [
      'Booking Confirmed',
      'Technician Assigned',
      'Service in Process',
      'Service Complete',
    ];
    final timestamps = <String?>[
      json['created_at']?.toString(),
      status == BookingStatus.accepted ||
              status == BookingStatus.inProgress ||
              status == BookingStatus.completed
          ? technician['assigned_at']?.toString()
          : null,
      startedAt,
      completedAt,
    ];
    final media = json['media'] is List ? json['media'] as List : const [];

    return Booking(
      id: json['id']?.toString() ?? '',
      serviceName: service['name']?.toString() ?? 'Service',
      iconAsset: _serviceIcon(service['name']?.toString() ?? ''),
      dateTime: scheduledAt,
      address: json['address']?.toString() ?? '',
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
      description: json['description']?.toString(),
      photoUrls: media
          .whereType<Map>()
          .map((item) => item['url']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList(),
      status: status,
      technicianName: technician['name']?.toString(),
      timeline: List.generate(labels.length, (index) {
        final done = status != BookingStatus.cancelled && index <= reached;
        final current = status != BookingStatus.cancelled && index == reached;
        final stamp = timestamps[index];
        return BookingStatusStep(
          label: labels[index],
          timestamp: done && stamp != null ? stamp : null,
          isDone: done && index < reached,
          isCurrent: current || (done && index == reached),
        );
      }),
    );
  }

  static String _serviceIcon(String name) {
    final value = name.toLowerCase();
    if (value.contains('plumb')) {
      return 'plumber';
    }
    if (value.contains('electric')) {
      return 'electrician';
    }
    if (value.contains('tv')) return 'tvRepair';
    if (value.contains('paint')) return 'painter';
    if (value.contains('clean')) return 'homeCleaning';
    if (value.contains('wash')) return 'washingMachine';
    if (value.contains('fridge') || value.contains('refriger')) {
      return 'fridgeRepair';
    }
    if (value.contains('cook') || value.contains('stove')) {
      return 'cookingRange';
    }
    return 'acRepair';
  }
}
