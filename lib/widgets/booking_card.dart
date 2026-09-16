import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/app_colors.dart';
import '../core/status_labels.dart';
import '../l10n/app_localizations.dart';
import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback? onTap;

  const BookingCard({super.key, required this.booking, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat('EEE, dd MMM yyyy').format(booking.dateTime);
    final timeStr = DateFormat('hh:mm a').format(booking.dateTime);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: AppColors.tileBackground, borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.build_outlined, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(booking.serviceName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.pendingBg, borderRadius: BorderRadius.circular(20)),
                        child: Text(bookingStatusLabel(l10n, booking.status), style: const TextStyle(color: AppColors.pendingText, fontSize: 12)),
                      ),
                    ],
                  ),
                  Text(l10n.serviceIdPrefix(booking.id), style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(dateStr, style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time, size: 13, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(timeStr, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 13, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Expanded(child: Text(booking.address, style: const TextStyle(fontSize: 12))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
