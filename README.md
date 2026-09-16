# Soft Creative — Home Service Booking App (Flutter)

Scaffold for the 4 screens in your mockups: **Home → My Booking → Notification → Profile**.

## Folder structure

```
soft_creative_app/
├── pubspec.yaml
└── lib/
    ├── main.dart                     # App entry, sets theme + home
    ├── core/
    │   ├── app_colors.dart           # Brand palette (blue) used everywhere
    │   └── app_theme.dart            # ThemeData
    ├── models/
    │   ├── booking_model.dart        # Booking + BookingStatus enum
    │   ├── notification_model.dart   # AppNotification + type enum
    │   └── service_category.dart     # 9 category icons for Home grid
    ├── widgets/
    │   ├── app_bottom_nav.dart       # Shared 4-tab bottom bar
    │   └── booking_card.dart         # Card reused by Home + Booking screens
    └── screens/
        ├── main_navigation.dart      # Owns tab index, wires screens together
        ├── home/home_screen.dart
        ├── booking/my_booking_screen.dart
        ├── notification/notification_screen.dart
        └── profile/profile_screen.dart
```

## How the 4 tabs connect

`MainNavigation` (`lib/screens/main_navigation.dart`) is the hub: it holds
one `Scaffold` with a shared `AppBottomNav` and an `IndexedStack` of the 4
tab screens, so switching tabs doesn't rebuild/lose scroll state.

## The real booking flow (pushed screens, not tabs)

Booking a service is a separate, **pushed** flow with its own back button —
it is not just "switch to the Booking tab." It matches your reference
screens exactly:

```
Home (tap a category tile)
   -> ServiceDetailScreen        lib/screens/service/service_detail_screen.dart
        "Select Book Now"
   -> BookingFormScreen          lib/screens/booking/booking_form_screen.dart
        pick date/time, address, problem description, upload photo
        "Booking Now"
   -> BookingConfirmationScreen  lib/screens/booking/booking_confirmation_screen.dart
        shows the generated Booking ID
        "View My Booking"
   -> BookingDetailScreen        lib/screens/booking/booking_detail_screen.dart
        full detail: date/time/address/description/photos,
        assigned technician, and the status timeline
```

`BookingFormScreen._submitBooking()` builds a real `Booking` object (with a
generated ID, the chosen date/time, description, and an initial timeline)
and passes it forward — that's the same `Booking` model used everywhere
else, so this flow and the **My Booking** tab share one source of truth.

**My Booking tab → Booking Detail**: tapping any `BookingCard` in
`MyBookingScreen` also pushes `BookingDetailScreen` for that booking, so
you land on the same status screen whether you just booked it or you're
checking on an older one.

**Notification → Booking Detail**: `_NotificationTile.onPressed` in
`notification_screen.dart` is stubbed with a `TODO` — wire it to look up
the booking by `notification.relatedBookingId` and push
`BookingDetailScreen`, once bookings live in shared state (see below)
rather than a local mock list per screen.

**Profile → Log Out**: stubbed in `_SettingsTile` for your auth logic.

Right now `MyBookingScreen` and `BookingFormScreen` each keep their own
mock data — swap that for a shared state solution (see below) once you
connect a backend, so a booking made through the flow actually appears in
the My Booking list.

## Suggested next steps

1. **State management**: replace the local mock lists in
   `MyBookingScreen` / `NotificationScreen` with `Provider`, `Riverpod`, or
   `Bloc` so a booking created on Home instantly reflects in Booking/Notification.
2. **Networking**: add a `lib/services/api_service.dart` (e.g. using `dio` or
   `http`) once you have a backend, and a `lib/services/` layer per model.
3. **Routing**: if you outgrow the simple `IndexedStack` pattern (e.g. need
   deep links or a detail page pushed on top of a tab), introduce
   `go_router` and keep `MainNavigation` as a `ShellRoute`.
4. **Assets**: the mockups' icon illustrations (wrench, faucet, AC unit,
   etc.) are currently swapped for Material icons in `service_category.dart`
   — drop your real icon/illustration assets into `assets/icons/` and update
   `pubspec.yaml` + the model to reference asset paths instead.

## Run it

```bash
flutter pub get
flutter run
```
