import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../services/api_service.dart';

class NotificationScreen extends StatefulWidget {
  final VoidCallback onViewBookings;

  const NotificationScreen({super.key, required this.onViewBookings});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _loading = true;
  String? _error;
  List<Map<String, dynamic>> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final items = await ApiService.instance.notifications();
      if (!mounted) return;
      setState(() {
        _items = items;
        _error = null;
        _loading = false;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.message;
        _loading = false;
      });
    }
  }

  Future<void> _openBooking(Map<String, dynamic> item) async {
    final id = item['id']?.toString();
    if (id != null) {
      try {
        await ApiService.instance.markNotificationRead(id);
      } on ApiException catch (error) {
        debugPrint('Could not mark notification as read: ${error.message}');
      }
    }
    widget.onViewBookings();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final today = DateUtils.dateOnly(DateTime.now());
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final item in _items) {
      final created =
          DateTime.tryParse(item['created_at']?.toString() ?? '')?.toLocal() ??
              DateTime.now();
      final day = DateUtils.dateOnly(created);
      final label = day == today
          ? l10n.todayLabel
          : day == today.subtract(const Duration(days: 1))
              ? l10n.yesterdayLabel
              : DateFormat('EEE, d MMM').format(created);
      grouped.putIfAbsent(label, () => []).add(item);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.notificationHeaderTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(l10n.notificationSubtitle,
                  style: const TextStyle(color: Colors.white70, height: 1.35)),
            ],
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_error!, textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            TextButton(
                                onPressed: _load, child: const Text('Retry')),
                          ],
                        ),
                      ),
                    )
                  : grouped.isEmpty
                      ? const Center(child: Text('No notifications yet.'))
                      : ListView(
                          padding: const EdgeInsets.all(20),
                          children: grouped.entries.expand((entry) sync* {
                            yield Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 6),
                              child: Text(entry.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            );
                            for (final item in entry.value) {
                              final payload = item['data'] is Map
                                  ? Map<String, dynamic>.from(
                                      item['data'] as Map)
                                  : const <String, dynamic>{};
                              final created = DateTime.tryParse(
                                      item['created_at']?.toString() ?? '')
                                  ?.toLocal();
                              yield _NotificationTile(
                                title: payload['title']?.toString() ?? '',
                                message: payload['body']?.toString() ?? '',
                                time: created == null
                                    ? ''
                                    : DateFormat('h:mm a').format(created),
                                hasBooking: payload['booking_id'] != null,
                                onViewBooking: () => _openBooking(item),
                              );
                            }
                          }).toList(),
                        ),
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool hasBooking;
  final VoidCallback onViewBooking;

  const _NotificationTile({
    required this.title,
    required this.message,
    required this.time,
    required this.hasBooking,
    required this.onViewBooking,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
              color: Color(0x080B5FA8), blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.tileBackground,
              child: Icon(Icons.notifications_outlined,
                  color: AppColors.primary, size: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(message,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(time,
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 11)),
                    const Spacer(),
                    if (hasBooking)
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.pendingBg,
                          foregroundColor: AppColors.pendingText,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        ),
                        onPressed: onViewBooking,
                        child: Text(l10n.viewBookingButton,
                            style: const TextStyle(fontSize: 12)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
