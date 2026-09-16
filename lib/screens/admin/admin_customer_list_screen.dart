import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../data/admin_booking_store.dart';
import '../../models/customer_profile.dart';
import 'admin_add_client_screen.dart';
import 'admin_customer_profile_screen.dart';

class AdminCustomerListScreen extends StatelessWidget {
  const AdminCustomerListScreen({super.key});

  // TODO: replace with data from your customer management API.
  static const _customers = [
    CustomerProfile(name: 'Jonh Smith', phone: '+855 12 111 222', id: 'ID-10021'),
    CustomerProfile(name: 'Mary Janeeeee', phone: '+855 12 333 444', id: 'ID-10022'),
    CustomerProfile(name: 'Nam Jungouk', phone: '+855 12 555 666', id: 'ID-10023'),
    CustomerProfile(name: 'Steve Roger', phone: '+855 12 777 888', id: 'ID-10024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppLocalizations.of(context)!.customersTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_rounded, color: AppColors.primary),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminAddClientScreen()),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: AdminBookingStore.instance,
        builder: (context, _) => ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          itemCount: _customers.length,
          itemBuilder: (context, index) => _CustomerTile(data: _customers[index]),
        ),
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  final CustomerProfile data;

  const _CustomerTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AdminCustomerProfileScreen(data: data)),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.tileBackground,
                child: Text(data.initials,
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(data.phone, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(AppLocalizations.of(context)!.bookingsCountSuffix(AdminBookingStore.instance.forCustomer(data.name).length),
                        style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
