import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../../core/app_colors.dart';
import '../../data/client_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/service_category.dart';
import '../../models/booking_model.dart';
import 'booking_confirmation_screen.dart';
import 'location_picker_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final ServiceCategory category;
  const BookingFormScreen({super.key, required this.category});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  late List<DateTime> _dates;
  final ScrollController _timeScrollController = ScrollController();
  int _selectedDateIndex = 1;
  final List<String> _times = [
    '8:00 AM',
    '10:00 AM',
    '12:00 PM',
    '2:00 PM',
    '4:00 PM',
    '6:00 PM',
  ];
  static const _timeSlots = [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 16, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
  ];
  int _selectedTimeIndex = 1;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final List<Uint8List> _selectedImages = [];
  final List<String> _photoPaths = [];
  static const _serviceAddress = '#12, Preysor, Phnom Penh';
  static const _defaultLocation = LatLng(11.5564, 104.9282); // Phnom Penh
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _dates = List.generate(5, (i) => today.add(Duration(days: i)));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _timeScrollController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    final today = DateTime.now();
    final selectedDate = _dates[_selectedDateIndex];
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(today) ? today : selectedDate,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(today.year + 1),
      helpText: l10n.selectServiceDateHelpText,
    );

    if (pickedDate == null || !mounted) return;

    setState(() {
      _dates = [
        pickedDate,
        ..._dates.where((date) =>
            date.year != pickedDate.year ||
            date.month != pickedDate.month ||
            date.day != pickedDate.day),
      ].take(5).toList();
      _selectedDateIndex = 0;
    });
  }

  void _moveDateWindow(int offset) {
    final today = DateUtils.dateOnly(DateTime.now());
    final firstDate =
        DateUtils.dateOnly(_dates.first.add(Duration(days: offset)));
    if (firstDate.isBefore(today)) return;

    setState(() {
      _dates =
          List.generate(5, (index) => firstDate.add(Duration(days: index)));
      _selectedDateIndex = offset > 0 ? 0 : _dates.length - 1;
    });
  }

  void _moveSelectedTime(int offset) {
    _selectTimeSlot(
        (_selectedTimeIndex + offset + _times.length) % _times.length);
  }

  void _selectTimeSlot(int index) {
    setState(() {
      _selectedTimeIndex = index;
      _selectedTime = _timeSlots[index];
    });
    if (_timeScrollController.hasClients) {
      final target = (index * 92.0).clamp(
        0.0,
        _timeScrollController.position.maxScrollExtent,
      );
      _timeScrollController.animateTo(
        target.toDouble(),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    }
  }

  String _formatTime(TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(time);
  }

  static const List<BoxShadow> _cardShadow = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 6)),
  ];

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  Future<void> _pickImages() async {
    final images = await _imagePicker.pickMultiImage(imageQuality: 80);
    if (images.isEmpty || !mounted) return;

    final imageBytes =
        await Future.wait(images.map((image) => image.readAsBytes()));
    if (!mounted) return;

    setState(() {
      _selectedImages.addAll(imageBytes);
      _photoPaths.addAll(images.map((image) => image.path));
    });
  }

  Future<void> _openLocation() async {
    final picked = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPickerScreen(
          initialLocation: _pickedLocation ?? _defaultLocation,
        ),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _pickedLocation = picked);
    }
  }

  void _submitBooking() {
    final l10n = AppLocalizations.of(context)!;
    final selectedDate = _dates[_selectedDateIndex];
    final categoryName = widget.category.name(l10n);
    final booking = Booking(
      id: 'BR-${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}-${DateTime.now().millisecondsSinceEpoch % 10000}',
      serviceName: categoryName,
      iconAsset: categoryName,
      dateTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      address: _serviceAddress,
      latitude: _pickedLocation?.latitude,
      longitude: _pickedLocation?.longitude,
      description: _descriptionController.text.trim().isEmpty
          ? l10n.noDescriptionProvided
          : _descriptionController.text.trim(),
      photoUrls: _photoPaths,
      status: BookingStatus.pending,
      timeline: [
        BookingStatusStep(
            label: l10n.bookingConfirmedStep, isDone: true, isCurrent: true),
        BookingStatusStep(label: l10n.technicianAssignedLabel),
        BookingStatusStep(label: l10n.serviceInProcessStep),
        BookingStatusStep(label: l10n.serviceCompleteStep),
      ],
    );

    ClientBookingStore.instance.addBooking(booking);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => BookingConfirmationScreen(booking: booking)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final weekdayLabels = [
      l10n.weekdayMon,
      l10n.weekdayTue,
      l10n.weekdayWed,
      l10n.weekdayThu,
      l10n.weekdayFri,
      l10n.weekdaySat,
      l10n.weekdaySun,
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
        title: Text(l10n.bookingDetailTitle,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.black),
              onPressed: () {})
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        children: [
          _sectionTitle(Icons.build_outlined, l10n.labelService),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.28),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Image.asset(widget.category.iconAsset,
                      fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(widget.category.name(l10n),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ),
                const Icon(Icons.chevron_right_rounded, color: Colors.white70),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(Icons.calendar_today_outlined, l10n.selectDateTitle),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _cardShadow,
            ),
            child: Row(
              children: [
                IconButton(
                  tooltip: l10n.previousDatesTooltip,
                  onPressed:
                      _dates.first.isAfter(DateUtils.dateOnly(DateTime.now()))
                          ? () => _moveDateWindow(-1)
                          : null,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints.tightFor(width: 28, height: 28),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Expanded(
                  child: SizedBox(
                    height: 78,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _dates.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        final d = _dates[i];
                        final selected = i == _selectedDateIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDateIndex = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            width: 68,
                            decoration: BoxDecoration(
                              gradient: selected
                                  ? const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.primaryDark
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: selected ? null : const Color(0xFFF4F5F7),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(weekdayLabels[d.weekday - 1],
                                    style: TextStyle(
                                        color: selected
                                            ? Colors.white70
                                            : AppColors.textSecondary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.4)),
                                const SizedBox(height: 6),
                                Text('${d.day}',
                                    style: TextStyle(
                                        color: selected
                                            ? Colors.white
                                            : AppColors.textPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.nextDatesTooltip,
                  onPressed: () => _moveDateWindow(1),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints.tightFor(width: 28, height: 28),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(Icons.access_time_outlined, l10n.selectTimeTitle),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.tileBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: AppColors.primary),
                const SizedBox(width: 10),
                Text(l10n.selectedTimePrefix(_formatTime(_selectedTime)),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: _cardShadow,
            ),
            child: Row(
              children: [
                IconButton(
                  tooltip: l10n.previousTimeTooltip,
                  onPressed: () => _moveSelectedTime(-1),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints.tightFor(width: 28, height: 28),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _timeScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(_times.length, (i) {
                      final selected = i == _selectedTimeIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: SizedBox(
                          width: 84,
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _selectTimeSlot(i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOutCubic,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 12),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.primary
                                      : const Color(0xFFF4F5F7),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withValues(alpha: 0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(_times[i],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: selected
                                            ? Colors.white
                                            : AppColors.textPrimary,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
                  ),
                ),
                IconButton(
                  tooltip: l10n.nextTimeTooltip,
                  onPressed: () => _moveSelectedTime(1),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints.tightFor(width: 28, height: 28),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(Icons.location_on_outlined, l10n.serviceAddressTitle),
          const SizedBox(height: 10),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            elevation: 0,
            child: InkWell(
              onTap: _openLocation,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _cardShadow,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: AppColors.tileBackground,
                          shape: BoxShape.circle),
                      child: const Icon(Icons.location_on_outlined,
                          color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.homeLabel,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text(
                            _pickedLocation == null
                                ? _serviceAddress
                                : '${l10n.pinnedPrefix}${_pickedLocation!.latitude.toStringAsFixed(5)}, '
                                    '${_pickedLocation!.longitude.toStringAsFixed(5)}',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.map_outlined,
                            size: 20, color: AppColors.primary),
                        const SizedBox(height: 2),
                        Text(l10n.mapLabel,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(
              Icons.description_outlined, l10n.problemDescriptionLabel),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: _cardShadow,
            ),
            padding: const EdgeInsets.all(4),
            child: TextField(
              controller: _descriptionController,
              maxLines: 4,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(12),
                hintText: l10n.describeIssueHint,
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(Icons.photo_camera_outlined, l10n.uploadPhotoTitle),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: _cardShadow,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: _pickImages,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        color: AppColors.tileBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.primaryLight, width: 1.4)),
                    child: const Icon(Icons.add_photo_alternate_outlined,
                        color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 64,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(_selectedImages[index],
                                width: 64, height: 64, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Transform.translate(
                              offset: const Offset(7, -7),
                              child: InkWell(
                                onTap: () => setState(() {
                                  _selectedImages.removeAt(index);
                                  _photoPaths.removeAt(index);
                                }),
                                child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColors.danger,
                                    child: Icon(Icons.close,
                                        size: 13, color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 4,
              shadowColor: AppColors.primary.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: _submitBooking,
            child: Text(l10n.bookingNowButton,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
