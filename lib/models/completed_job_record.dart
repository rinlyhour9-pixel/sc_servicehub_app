import 'package:intl/intl.dart';

import 'technician_job.dart';

/// A job the technician has finished, carrying the report they submitted.
class CompletedJobRecord {
  final TechnicianJob job;
  final String workDescription;
  final DateTime startedAt;
  final DateTime endedAt;

  const CompletedJobRecord({
    required this.job,
    required this.workDescription,
    required this.startedAt,
    required this.endedAt,
  });

  String get startLabel => DateFormat('hh:mm a').format(startedAt);
  String get endLabel => DateFormat('hh:mm a').format(endedAt);
  String get completedOnLabel => DateFormat('dd MMM yyyy').format(endedAt);

  String get durationLabel {
    final diff = endedAt.difference(startedAt);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    if (hours <= 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }
}
