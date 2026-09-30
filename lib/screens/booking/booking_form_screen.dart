import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_colors.dart';
import '../../services/api_service.dart';
import '../../state/client_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/service_category.dart';
import 'booking_confirmation_screen.dart';

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
  List<DateTime> _timeSlots = const [];
  int _selectedTimeIndex = 0;
  DateTime? _selectedTime;
  bool _loadingAvailability = false;
  String? _availabilityError;
  int _availabilityRequestId = 0;
  final TextEditingController _descriptionController = TextEditingController();
  static const _defaultServiceAddress = '#12, Preysor, Phnom Penh';
  late final TextEditingController _addressController =
      TextEditingController(text: _defaultServiceAddress);
  final List<XFile> _selectedPhotos = [];
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _dates = List.generate(5, (i) => today.add(Duration(days: i)));
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAvailability());
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _addressController.dispose();
    _timeScrollController.dispose();
    super.dispose();
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
    _loadAvailability();
  }

  void _moveSelectedTime(int offset) {
    if (_timeSlots.isEmpty) return;
    _selectTimeSlot(
        (_selectedTimeIndex + offset + _timeSlots.length) % _timeSlots.length);
  }

  void _selectTimeSlot(int index) {
    if (index < 0 || index >= _timeSlots.length) return;
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

  Future<ApiServiceItem> _findService() async {
    final wanted = _normalize(widget.category.id.name);
    final items = await ApiService.instance.services();
    for (final item in items) {
      if (_normalize(item.name) == wanted) return item;
    }
    throw const ApiException(
        'This service is not available from the booking system yet.');
  }

  Future<void> _loadAvailability() async {
    final requestId = ++_availabilityRequestId;
    setState(() {
      _loadingAvailability = true;
      _availabilityError = null;
      _timeSlots = const [];
      _selectedTime = null;
    });
    try {
      final service = await _findService();
      final date = _dates[_selectedDateIndex];
      final slots = await ApiService.instance.availability(
        serviceId: service.id,
        date: date,
      );
      if (!mounted || requestId != _availabilityRequestId) return;
      setState(() {
        _timeSlots = slots;
        _selectedTimeIndex = 0;
        _selectedTime = slots.isEmpty ? null : slots.first;
      });
    } on ApiException catch (error) {
      if (!mounted || requestId != _availabilityRequestId) return;
      setState(() {
        _timeSlots = const [];
        _selectedTime = null;
        _availabilityError = error.message;
      });
    } finally {
      if (mounted && requestId == _availabilityRequestId) {
        setState(() => _loadingAvailability = false);
      }
    }
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
    try {
      final photos = await ImagePicker().pickMultiImage(
        limit: 8,
        imageQuality: 80,
        maxWidth: 1600,
        maxHeight: 1600,
      );
      if (!mounted || photos.isEmpty) return;
      setState(() {
        _selectedPhotos
          ..clear()
          ..addAll(photos.take(8));
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not select photos: $error')),
        );
      }
    }
  }

  Future<void> _submitBooking() async {
    if (_submitting) return;
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(_availabilityError ?? 'Select an available time.')),
      );
      return;
    }
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a service address.')),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      final match = await _findService();
      final booking = await ApiService.instance.createBooking(
        serviceId: match.id,
        scheduledAt: _selectedTime!,
        address: _addressController.text.trim(),
        description: _descriptionController.text,
        photos: _selectedPhotos,
      );
      ClientBookingStore.instance.addBooking(booking);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BookingConfirmationScreen(booking: booking)),
      );
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String _normalize(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

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
                          onTap: () {
                            setState(() => _selectedDateIndex = i);
                            _loadAvailability();
                          },
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
                Text(
                    _selectedTime == null
                        ? (_loadingAvailability
                            ? 'Loading times…'
                            : 'No available times')
                        : l10n.selectedTimePrefix(_formatTime(
                            TimeOfDay.fromDateTime(_selectedTime!))),
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
                        children: List.generate(_timeSlots.length, (i) {
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
                                child: Text(
                                    _formatTime(
                                        TimeOfDay.fromDateTime(_timeSlots[i])),
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
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: _cardShadow,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.tileBackground,
                    child: Icon(Icons.location_on_outlined,
                        color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _addressController,
                      textCapitalization: TextCapitalization.words,
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: l10n.homeLabel,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
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
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
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
                ..._selectedPhotos.map((photo) => Container(
                      constraints: const BoxConstraints(maxWidth: 180),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.tileBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.image_outlined,
                              color: AppColors.primary, size: 18),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(photo.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    )),
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
            onPressed: _submitting ? null : _submitBooking,
            child: Text(_submitting ? 'Sending...' : l10n.bookingNowButton,
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
