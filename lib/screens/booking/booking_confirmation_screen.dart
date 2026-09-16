import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/booking_model.dart';
import 'booking_detail_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Booking booking;
  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(color: AppColors.tileBackground, shape: BoxShape.circle),
                child: const Icon(Icons.assignment_turned_in_outlined, size: 72, color: AppColors.primary),
              ),
              const SizedBox(height: 28),
              Text(l10n.bookingRequestSendTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                l10n.bookingReceivedBody,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.bookingIdLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(booking.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    // Replaces this screen (not pushes) so the back arrow
                    // from Booking Detail returns to Home, not this receipt.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => BookingDetailScreen(booking: booking)),
                    );
                  },
                  child: Text(l10n.viewMyBookingButton, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
