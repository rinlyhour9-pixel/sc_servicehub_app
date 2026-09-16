import 'package:flutter/material.dart';

/// Called when a technician submits their completion report for the job
/// already carried by the current screen (Job Detail -> In Progress -> Complete).
typedef JobSubmitCallback = void Function(
    String workDescription, DateTime startedAt, DateTime endedAt);

/// Called by a task-list screen (which shows many jobs) once one of them is
/// submitted, so the caller knows which job to move from assigned to completed.
typedef JobCompletionCallback = void Function(
    TechnicianJob job, String workDescription, DateTime startedAt, DateTime endedAt);

/// A single job assigned to a technician, carried through the
/// Job Detail -> Job In Progress -> Complete Job flow.
class TechnicianJob {
  final IconData icon;
  final String bookingId;
  final String bookedOn;
  final String customerName;
  final String customerPhone;
  final String service;
  final String scheduledDateTime;
  final String address;
  final double? latitude; // pin the client dropped on the map when booking
  final double? longitude;
  final String problemDescription;
  final int photoCount;

  const TechnicianJob({
    required this.icon,
    required this.bookingId,
    required this.bookedOn,
    required this.customerName,
    required this.customerPhone,
    required this.service,
    required this.scheduledDateTime,
    required this.address,
    this.latitude,
    this.longitude,
    required this.problemDescription,
    required this.photoCount,
  });
}
