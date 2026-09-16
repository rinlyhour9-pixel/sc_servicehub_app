import 'package:flutter/widgets.dart';

/// Font family names registered in `pubspec.yaml`.
///
/// Place font files in `assets/fonts/`, register them in `pubspec.yaml`, then
/// add the corresponding family name here.
class AppFonts {
  AppFonts._();

  static const String poppins = 'Poppins';
  static const String kantumruyPro = 'KantumruyPro';

  /// Poppins doesn't cover Khmer glyphs, so Khmer locales use KantumruyPro instead.
  static String forLocale(Locale locale) =>
      locale.languageCode == 'km' ? kantumruyPro : poppins;
}
