import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/booking_model.dart';

class BookingDetailScreen extends StatelessWidget {
  final Booking booking;
  const BookingDetailScreen({super.key, required this.booking});

  void _showAddress(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.unableOpenMap)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat('EEE, dd MMM yyyy').format(booking.dateTime);
    final timeStr = DateFormat('hh:mm a').format(booking.dateTime);
    final techName = booking.technicianName ?? 'Not assigned yet';
    final techPhone = booking.technicianPhone ?? '';
    final statusLabel = switch (booking.status) {
      BookingStatus.pending => l10n.statusPending,
      BookingStatus.accepted => l10n.statusAccepted,
      BookingStatus.inProgress => l10n.statusInProgress,
      BookingStatus.completed => l10n.statusCompleted,
      BookingStatus.cancelled => l10n.statusCancelled,
    };

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
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: .25), blurRadius: 16, offset: const Offset(0, 7))],
            ),
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: const BoxDecoration(color: Color(0x33FFFFFF), borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(statusLabel, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
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
            onTap: () => _showAddress(context),
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
            decoration: BoxDecoration(color: AppColors.tileBackground, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primaryLight)),
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
          Text(l10n.bookingStatusTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: const BoxDecoration(color: AppColors.background, boxShadow: [BoxShadow(color: Color(0x10000000), blurRadius: 14, offset: Offset(0, -4))]),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Booking status is shown in this static preview.')),
            ),
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
