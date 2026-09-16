import 'package:flutter/foundation.dart';

import '../models/booking_model.dart';

/// Shared source of truth for the signed-in client's bookings. Submitting the
/// booking form adds straight into [upcoming] here, so it's visible the
/// moment the user opens "My Booking" — instead of the confirmation screen
/// being a dead end that only shows the one booking it was handed.
class ClientBookingStore extends ChangeNotifier {
  ClientBookingStore._internal();
  static final ClientBookingStore instance = ClientBookingStore._internal();

  // TODO: replace with data from your booking API/service layer.
  final List<Booking> upcoming = [
    Booking(
      id: 'BR-240521-1287',
      serviceName: 'AC Repair',
      iconAsset: 'ac',
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
      address: '#12, Street 123, Preysor, Phnom Penh, Cambodia',
      description: 'Ac not cooling well and making strange noise',
      photoUrls: const ['p1', 'p2', 'p3'],
      status: BookingStatus.accepted,
      technicianName: 'Sokun Therayuk',
      technicianPhone: '010314240',
      timeline: const [
        BookingStatusStep(label: 'Booking Confirmed', timestamp: '20 May 2024, 02:30 PM', isDone: true),
        BookingStatusStep(label: 'Technician Assigned', timestamp: '20 May 2024, 04:30 PM', isDone: true, isCurrent: true),
        BookingStatusStep(label: 'Service in Process', timestamp: 'Pending'),
        BookingStatusStep(label: 'Service Complete', timestamp: 'Pending'),
      ],
    ),
    Booking(
      id: 'BR-240521-1288',
      serviceName: 'Plumber Repair',
      iconAsset: 'plumber',
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 8)),
      address: '#12, St. 310, Boeung Keng Kang, Phnom Penh',
      description: 'Kitchen sink is leaking under the cabinet',
      status: BookingStatus.pending,
      timeline: const [
        BookingStatusStep(label: 'Booking Confirmed', isDone: true, isCurrent: true),
        BookingStatusStep(label: 'Technician Assigned'),
        BookingStatusStep(label: 'Service in Process'),
        BookingStatusStep(label: 'Service Complete'),
      ],
    ),
  ];

  final List<Booking> history = [
    Booking(
      id: 'BR-240401-1001',
      serviceName: 'TV Repair',
      iconAsset: 'tv',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      address: '#12, St. 310, Boeung Keng Kang, Phnom Penh',
      description: 'No display on power on',
      status: BookingStatus.completed,
      technicianName: 'Dara Vong',
      technicianPhone: '098765432',
      timeline: const [
        BookingStatusStep(label: 'Booking Confirmed', timestamp: '01 Apr 2024, 09:00 AM', isDone: true),
        BookingStatusStep(label: 'Technician Assigned', timestamp: '01 Apr 2024, 10:00 AM', isDone: true),
        BookingStatusStep(label: 'Service in Process', timestamp: '01 Apr 2024, 11:00 AM', isDone: true),
        BookingStatusStep(label: 'Service Complete', timestamp: '01 Apr 2024, 01:00 PM', isDone: true),
      ],
    ),
  ];

  void addBooking(Booking booking) {
    upcoming.insert(0, booking);
    notifyListeners();
  }
}
