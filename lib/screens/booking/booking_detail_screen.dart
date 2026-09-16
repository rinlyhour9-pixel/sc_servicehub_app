import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/booking_model.dart';

class BookingDetailScreen extends StatelessWidget {
  final Booking booking;
  const BookingDetailScreen({super.key, required this.booking});

  Future<void> _openMap(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final hasPin = booking.latitude != null && booking.longitude != null;
    final mapUrl = hasPin
        ? Uri.https('www.google.com', '/maps/search/', {
            'api': '1',
            'query': '${booking.latitude},${booking.longitude}',
          })
        : Uri.https('www.google.com', '/maps/search/', {
            'api': '1',
            'query': booking.address,
          });
    final opened = await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.unableOpenMap)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat('EEE, dd MMM yyyy').format(booking.dateTime);
    final timeStr = DateFormat('hh:mm a').format(booking.dateTime);
    // Demo technician if the booking hasn't been assigned one yet.
    final techName = booking.technicianName ?? 'Sokun Therayuk';
    final techPhone = booking.technicianPhone ?? '010314240';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black), onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst)),
        title: Text(l10n.bookingDetailTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.ac_unit, color: Colors.white, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${booking.serviceName}${l10n.serviceSuffix}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('${l10n.bookingIdPrefix}#${booking.id}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InfoRow(icon: Icons.calendar_today_outlined, label: l10n.dateLabel, value: dateStr),
          _InfoRow(icon: Icons.access_time, label: l10n.timeLabel, value: timeStr),
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: l10n.labelAddress,
            value: booking.address,
            trailing: const Icon(Icons.navigation_outlined, color: AppColors.primary, size: 20),
            onTap: () => _openMap(context),
          ),
          _InfoRow(icon: Icons.description_outlined, label: l10n.labelDescription, value: booking.description ?? '-'),
          _InfoRow(icon: Icons.photo_library_outlined, label: l10n.photoLabel, value: l10n.photosCountSuffix(booking.photoUrls.length)),
          if (booking.photoUrls.isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: booking.photoUrls.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  if (i == booking.photoUrls.length) {
                    return Container(
                      width: 72,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                      child: const Icon(Icons.add, color: AppColors.textSecondary, size: 28),
                    );
                  }
                  return Container(
                    width: 72,
                    decoration: BoxDecoration(color: AppColors.tileBackground, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.ac_unit, color: AppColors.primary, size: 32),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.tileBackground, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const CircleAvatar(radius: 24, backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.white, size: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.assignedTechnicianLabel, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      Text(techName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(techPhone, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                _CircleIconButton(icon: Icons.call_outlined, onTap: () {}),
                const SizedBox(width: 8),
                _CircleIconButton(icon: Icons.send_outlined, onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.bookingStatusTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 14),
          _StatusTimeline(steps: booking.timeline),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('💳', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(child: Text(l10n.payAfterServiceNote, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: null,
            child: Text(l10n.technicianAssignedLabel, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 16, backgroundColor: AppColors.tileBackground, foregroundColor: AppColors.primary, child: Icon(icon, size: 16)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: onTap == null
          ? row
          : InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap, child: row),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(icon, size: 16, color: AppColors.primary)),
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  final List<BookingStatusStep> steps;
  const _StatusTimeline({required this.steps});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        final isLast = i == steps.length - 1;
        final color = (step.isDone || step.isCurrent) ? AppColors.primary : Colors.grey.shade300;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: step.isDone ? AppColors.primary : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2),
                    ),
                    child: step.isDone
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : (step.isCurrent ? Container(margin: const EdgeInsets.all(5), decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)) : null),
                  ),
                  if (!isLast) Expanded(child: Container(width: 2, color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(step.timestamp ?? l10n.statusPending, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
