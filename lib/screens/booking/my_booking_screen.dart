import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../data/client_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/booking_card.dart';
import 'booking_detail_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  bool showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ClientBookingStore.instance,
      builder: (context, _) => _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final store = ClientBookingStore.instance;
    final list = showUpcoming ? store.upcoming : store.history;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.myBookingTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              Text(l10n.viewServiceBookingSubtitle,
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    _TabButton(label: l10n.upcomingTab, selected: showUpcoming, onTap: () => setState(() => showUpcoming = true)),
                    const SizedBox(width: 12),
                    _TabButton(label: l10n.historyTab, selected: !showUpcoming, onTap: () => setState(() => showUpcoming = false)),
                  ],
                ),
                const SizedBox(height: 20),
                Text(showUpcoming ? l10n.upcomingBookingsTitle : l10n.pastBookingsTitle, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                Expanded(
                  child: list.isEmpty
                      ? Center(child: Text(l10n.noBookingsYet, style: const TextStyle(color: AppColors.textSecondary)))
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, i) => BookingCard(
                            booking: list[i],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => BookingDetailScreen(booking: list[i])),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: selected ? AppColors.primary : Colors.grey.shade300),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: selected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
