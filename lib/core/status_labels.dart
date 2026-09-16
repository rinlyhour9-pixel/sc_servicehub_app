import '../l10n/app_localizations.dart';
import '../models/admin_booking_entry.dart';
import '../models/booking_model.dart';

/// Translated display text for enum-backed statuses. Kept here (instead of a
/// getter on the model) because translating requires a [BuildContext] via
/// [AppLocalizations], which model classes shouldn't depend on.
String adminStageLabel(AppLocalizations l10n, AdminBookingStage stage) => switch (stage) {
      AdminBookingStage.pending => l10n.statusPending,
      AdminBookingStage.inProgress => l10n.statusInProgress,
      AdminBookingStage.complete => l10n.statusComplete,
    };

String bookingStatusLabel(AppLocalizations l10n, BookingStatus status) => switch (status) {
      BookingStatus.pending => l10n.statusPending,
      BookingStatus.accepted => l10n.statusAccepted,
      BookingStatus.inProgress => l10n.statusInProgress,
      BookingStatus.completed => l10n.statusCompleted,
      BookingStatus.cancelled => l10n.statusCancelled,
    };
