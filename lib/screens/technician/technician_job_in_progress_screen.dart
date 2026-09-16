import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/technician_job.dart';
import 'technician_complete_job_screen.dart';

class TechnicianJobInProgressScreen extends StatefulWidget {
  final TechnicianJob job;
  final JobSubmitCallback onSubmitted;

  const TechnicianJobInProgressScreen({
    super.key,
    required this.job,
    required this.onSubmitted,
  });

  @override
  State<TechnicianJobInProgressScreen> createState() => _TechnicianJobInProgressScreenState();
}

class _TechnicianJobInProgressScreenState extends State<TechnicianJobInProgressScreen> {
  late final DateTime _startedAt = DateTime.now();
  final _notesController = TextEditingController();
  final _imagePicker = ImagePicker();
  final List<Uint8List> _photos = [];
  static const _maxPhotos = 6;

  @override
  void dispose() {
    _notesController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final startedLabel = DateFormat('hh:mm a').format(_startedAt);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.jobInProgressTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                      Text(l10n.activeServiceLabel,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                      const SizedBox(height: 4),
                      Text(widget.job.bookingId,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('${widget.job.service}${l10n.startedAtSuffix}$startedLabel',
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Text(l10n.statusInProgress,
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.workNotesDetailLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: .4)),
                const SizedBox(height: 10),
                TextField(
                  controller: _notesController,
                  minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: l10n.addNoteCurrentWorkHint,
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
                Text(l10n.uploadProgressPhotosLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: .4)),
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
                            border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt_outlined,
                                  color: AppColors.textSecondary, size: 20),
                              const SizedBox(height: 4),
                              Text(l10n.addPhoto,
                                  style:
                                      const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TechnicianCompleteJobScreen(
                          job: widget.job,
                          startedAt: _startedAt,
                          workNotes: _notesController.text,
                          onSubmitted: widget.onSubmitted,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(l10n.completeJobTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
