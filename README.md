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

`BookingFormScreen` loads the matching active service and available appointment
slots from the Laravel API. Submitting the form sends the selected time,
address, description, and optional photos. The server booking is then shown in
the confirmation, detail, and My Booking screens.

The notification tab loads the signed-in user's notifications and marks a
notification read when its booking action is selected. Logging out clears the
saved token and asks the API to revoke it.
## Connected behavior

Client sign-in, sign-up, password reset requests, service availability,
bookings, photo uploads, notifications, and logout use the Laravel API. The
client booking store is refreshed from the signed-in account. Admin and
technician sign-in use the same API, while their dashboards still need their
API data wired into the screens.

The service illustrations remain bundled app assets. The app matches each
service tile to an active backend service by name.
## Run it

```bash
flutter pub get
flutter run
```

## Connect to the service system API

The app uses the Laravel mobile API in `sc_servicehub_system` for sign-in,
account creation, customer bookings, available time slots, and notifications.
Sanctum bearer tokens are stored with the platform secure-storage plugin.

Set the API root URL when running against a deployed server:

```bash
flutter run --dart-define=API_BASE_URL=https://your-host.example/api
```

The default development URL is `http://localhost:8000/api` for web, desktop,
and iOS Simulator, and `http://10.0.2.2:8000/api` for the Android emulator.
For a physical device, set `API_BASE_URL` to the computer's reachable LAN
address. Use HTTPS for deployed builds; Android cleartext access is enabled for
debug builds only.

Before booking, the system must return active entries from `GET /api/services`
whose names match the app service names (Electrician, Plumber, AC Repair, TV
Repair, Painter, Home Cleaning, Cooking Range, Washing Machine, Fridge Repair).
The current backend seeder creates service categories, while the mobile API
reads its separate `services` table. Add the mobile service rows on the backend
or the booking form will report that the selected service is unavailable.
