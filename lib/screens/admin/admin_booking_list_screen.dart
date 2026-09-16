import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/status_labels.dart';
import '../../data/admin_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/admin_booking_entry.dart';
import 'admin_track_booking_screen.dart';

class AdminBookingListScreen extends StatefulWidget {
  final AdminBookingStage? initialFilter;

  const AdminBookingListScreen({super.key, this.initialFilter});

  @override
  State<AdminBookingListScreen> createState() => _AdminBookingListScreenState();
}

class _AdminBookingListScreenState extends State<AdminBookingListScreen> {
  late AdminBookingStage? _filter = widget.initialFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.totalBookingTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Row(
              children: [
                _FilterTab(
                    label: l10n.filterAll,
                    selected: _filter == null,
                    onTap: () => setState(() => _filter = null)),
                const SizedBox(width: 8),
                _FilterTab(
                    label: l10n.statusPending,
                    selected: _filter == AdminBookingStage.pending,
                    onTap: () => setState(() => _filter = AdminBookingStage.pending)),
                const SizedBox(width: 8),
                _FilterTab(
                    label: l10n.statusInProgress,
                    selected: _filter == AdminBookingStage.inProgress,
                    onTap: () => setState(() => _filter = AdminBookingStage.inProgress)),
                const SizedBox(width: 8),
                _FilterTab(
                    label: l10n.statusComplete,
                    selected: _filter == AdminBookingStage.complete,
                    onTap: () => setState(() => _filter = AdminBookingStage.complete)),
              ],
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: AdminBookingStore.instance,
              builder: (context, _) {
                final bookings = AdminBookingStore.instance.bookings;
                final filtered = _filter == null
                    ? bookings
                    : bookings.where((b) => b.stage == _filter).toList();
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) => _BookingListTile(data: filtered[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingListTile extends StatelessWidget {
  final AdminBookingEntry data;

  const _BookingListTile({required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AdminTrackBookingScreen(bookingId: data.id),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(data.id,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                    child: Text(adminStageLabel(l10n, data.stage),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(data.customer, style: const TextStyle(color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Text(data.service,
                        style: const TextStyle(
                            color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                  Text(data.dateTime,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    data.technician != null ? Icons.engineering_rounded : Icons.person_off_outlined,
                    size: 14,
                    color: data.technician != null ? AppColors.primary : const Color(0xFFE2711D),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.technician?.name ?? l10n.statusUnassigned,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: data.technician != null ? AppColors.textSecondary : const Color(0xFFE2711D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
