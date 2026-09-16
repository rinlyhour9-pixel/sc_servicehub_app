enum NotificationType {
  technicianAssigned,
  technicianArrived,
  serviceComplete,
  promo
}

class AppNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String timeAgo; // "5 min ago", "Yesterday"
  final DateTime date;
  final String? avatar;
  final String?
      relatedBookingId; // links back to a Booking, powers "View booking"

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.date,
    this.avatar,
    this.relatedBookingId,
  });
}
