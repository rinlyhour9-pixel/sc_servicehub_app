import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/status_labels.dart';
import '../../data/admin_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/admin_booking_entry.dart';
import '../../models/technician_profile.dart';

/// Admin-facing view of a single booking's repair progress. Reads (and, via
/// Assign Technician, writes) straight through [AdminBookingStore] so the
/// change is visible on Total Booking, Today's Schedule, and the customer's
/// profile as soon as this screen updates it.
class AdminTrackBookingScreen extends StatefulWidget {
  final String bookingId;

  const AdminTrackBookingScreen({super.key, required this.bookingId});

  @override
  State<AdminTrackBookingScreen> createState() => _AdminTrackBookingScreenState();
}

class _AdminTrackBookingScreenState extends State<AdminTrackBookingScreen> {
  static const _timestamps = [
    '20 May 2024, 02:30 PM',
    '20 May 2024, 04:30 PM',
    '20 May 2024, 05:30 PM',
    '20 May 2024, 06:30 PM',
  ];

  List<String> _stepLabels(AppLocalizations l10n) => [
        l10n.bookingReceivedStep,
        l10n.technicianAssignedLabel,
        l10n.repairInProgressStep,
        l10n.serviceCompleteStep,
      ];

  int _doneCount(AdminBookingEntry entry) => switch (entry.stage) {
        AdminBookingStage.pending => entry.technician != null ? 2 : 1,
        AdminBookingStage.inProgress => 2,
        AdminBookingStage.complete => 4,
      };

  int? _currentIndex(AdminBookingEntry entry) {
    if (entry.stage == AdminBookingStage.pending && entry.technician == null) return 1;
    if (entry.stage == AdminBookingStage.inProgress) return 2;
    return null;
  }

  String _timestampFor(AdminBookingEntry entry, int index) {
    if (index == 1 && entry.stage == AdminBookingStage.pending) {
      return entry.assignedAt != null
          ? DateFormat('dd MMM yyyy, hh:mm a').format(entry.assignedAt!)
          : '-';
    }
    return _timestamps[index];
  }

  Future<void> _openAssignSheet() async {
    final l10n = AppLocalizations.of(context)!;
    final selected = await showModalBottomSheet<TechnicianProfile>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.assignTechnicianTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.5),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: TechnicianProfile.demoDirectory.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final tech = TechnicianProfile.demoDirectory[index];
                    return _AssignTechnicianTile(
                      data: tech,
                      onTap: () => Navigator.pop(sheetContext, tech),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) {
      AdminBookingStore.instance.assignTechnician(widget.bookingId, selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: AdminBookingStore.instance,
      builder: (context, _) {
        final entry = AdminBookingStore.instance.byId(widget.bookingId);
        final hasTechnician = entry.technician != null;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(l10n.trackBookingTitle,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.share_rounded, color: Colors.black),
                  onPressed: () {}),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.primary,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.id,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(entry.service,
                              style: const TextStyle(color: Colors.white, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(entry.dateTime,
                              style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                    Text(adminStageLabel(l10n, entry.stage),
                        style: const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.statusProcessTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 16),
                    _Timeline(
                      labels: _stepLabels(l10n),
                      timestampFor: (i) => _timestampFor(entry, i),
                      doneCount: _doneCount(entry),
                      currentIndex: _currentIndex(entry),
                    ),
                    const SizedBox(height: 6),
                    Text(l10n.technicianInformationTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 10),
                    hasTechnician
                        ? _TechnicianCard(data: entry.technician!)
                        : _AssignTechnicianPrompt(onTap: _openAssignSheet),
                    if (entry.stage == AdminBookingStage.complete) ...[
                      const SizedBox(height: 22),
                      Text(l10n.serviceRepairReportTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 12),
                      const _ReportPhotos(),
                      const SizedBox(height: 14),
                      TextField(
                        minLines: 3,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: l10n.addNoteOptionalHint,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: AppColors.border)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text(l10n.confirmButton,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<String> labels;
  final String Function(int index) timestampFor;
  final int doneCount;
  final int? currentIndex;

  const _Timeline({
    required this.labels,
    required this.timestampFor,
    required this.doneCount,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(labels.length, (i) {
        final isDone = i < doneCount;
        final isCurrent = i == currentIndex;
        final isLast = i == labels.length - 1;
        final lineColor = isDone ? AppColors.primary : Colors.grey.shade300;
        final hasTimestamp = isDone || isCurrent;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.primary : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: (isDone || isCurrent)
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          width: 2),
                    ),
                    child: isDone
                        ? const Icon(Icons.check, size: 15, color: Colors.white)
                        : (isCurrent
                            ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      color: AppColors.primary, shape: BoxShape.circle),
                                ),
                              )
                            : null),
                  ),
                  if (!isLast) Expanded(child: Container(width: 2, color: lineColor)),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(labels[i],
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(hasTimestamp ? timestampFor(i) : '-',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
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

class _AssignTechnicianPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const _AssignTechnicianPrompt({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Icon(Icons.person_search_rounded, size: 32, color: AppColors.textSecondary),
          const SizedBox(height: 8),
          Text(l10n.noTechnicianAssignedYet,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
              label: Text(l10n.assignTechnicianTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignTechnicianTile extends StatelessWidget {
  final TechnicianProfile data;
  final VoidCallback onTap;

  const _AssignTechnicianTile({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const ClipOval(
                child: Image(
                  image: AssetImage(AppAssets.profileClient),
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(data.skillSummary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: data.online ? const Color(0xFFE1F5EA) : AppColors.tileBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  data.online ? l10n.statusOnline : l10n.statusOffline,
                  style: TextStyle(
                    color: data.online ? AppColors.success : AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechnicianCard extends StatelessWidget {
  final TechnicianProfile data;

  const _TechnicianCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClipOval(
            child: Image(
              image: AssetImage(AppAssets.profileClient),
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(data.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: data.online ? const Color(0xFFE1F5EA) : AppColors.tileBackground,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        data.online ? l10n.statusOnline : l10n.statusOffline,
                        style: TextStyle(
                            color: data.online ? AppColors.success : AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(data.phone,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 2),
                Text('${l10n.skillPrefixLabel}${data.skillSummary}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportPhotos extends StatelessWidget {
  const _ReportPhotos();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 2 ? 0 : 10),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.tileBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.build_circle_outlined,
                    color: AppColors.primary, size: 28),
              ),
            ),
          ),
        );
      }),
    );
  }
}
