import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/technician_job.dart';

class TechnicianCompleteJobScreen extends StatefulWidget {
  final TechnicianJob job;
  final DateTime startedAt;
  final String workNotes;
  final JobSubmitCallback onSubmitted;

  const TechnicianCompleteJobScreen({
    super.key,
    required this.job,
    required this.startedAt,
    required this.workNotes,
    required this.onSubmitted,
  });

  @override
  State<TechnicianCompleteJobScreen> createState() => _TechnicianCompleteJobScreenState();
}

class _TechnicianCompleteJobScreenState extends State<TechnicianCompleteJobScreen> {
  late final DateTime _endedAt = DateTime.now();
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.workNotes);
  final _imagePicker = ImagePicker();
  final List<Uint8List> _photos = [];
  static const _maxPhotos = 6;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addPhoto() async {
    final images = await _imagePicker.pickMultiImage(imageQuality: 80);
    if (images.isEmpty || !mounted) return;

    final remaining = _maxPhotos - _photos.length;
    final picked = images.take(remaining);
    final bytes = await Future.wait(picked.map((image) => image.readAsBytes()));
    if (!mounted) return;

    setState(() => _photos.addAll(bytes));
  }

  void _removePhoto(int index) => setState(() => _photos.removeAt(index));

  String get _durationLabel {
    final diff = _endedAt.difference(widget.startedAt);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    if (hours <= 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    widget.onSubmitted(_descriptionController.text, widget.startedAt, _endedAt);
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.reportSubmittedMsg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final startLabel = DateFormat('hh:mm a').format(widget.startedAt);
    final endLabel = DateFormat('hh:mm a').format(_endedAt);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.completeJobTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Text(l10n.customerPhotosAfterLabel,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: .4)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var i = 0; i < _photos.length; i++)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(_photos[i], width: 84, height: 84, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: InkWell(
                        onTap: () => _removePhoto(i),
                        child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.danger,
                            child: Icon(Icons.close, size: 13, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              if (_photos.length < _maxPhotos)
                InkWell(
                  onTap: _addPhoto,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary, size: 20),
                        const SizedBox(height: 4),
                        Text(l10n.addPhoto,
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          Text(l10n.workDescriptionLabel,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: .4)),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: l10n.summarizeWorkHint,
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
          const SizedBox(height: 22),
          Text(l10n.workDurationLabel,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: .4)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _DurationColumn(label: l10n.startTimeLabel, value: startLabel)),
              Expanded(child: _DurationColumn(label: l10n.endTimeLabel, value: endLabel)),
              Expanded(
                child: _DurationColumn(
                    label: l10n.totalLabel, value: _durationLabel, valueColor: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 26),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l10n.submitReportButton,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DurationColumn({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: valueColor ?? AppColors.textPrimary)),
      ],
    );
  }
}
