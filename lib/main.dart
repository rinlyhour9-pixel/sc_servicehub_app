import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'models/user_role.dart';
import 'screens/admin/admin_navigation.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/start/start_screen.dart';
import 'screens/technician/technician_navigation.dart';

void main() {
  runApp(const SoftCreativeApp());
}

class SoftCreativeApp extends StatefulWidget {
  const SoftCreativeApp({super.key});

  @override
  State<SoftCreativeApp> createState() => _SoftCreativeAppState();
}

class _SoftCreativeAppState extends State<SoftCreativeApp> {
  static const _localeKey = 'app_locale';

  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (mounted && code != null) setState(() => _locale = Locale(code));
  }

  Future<void> _changeLocale(Locale locale) async {
    setState(() => _locale = locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soft Creative',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(_locale),
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: _AppShell(
        locale: _locale,
        onLocaleChanged: _changeLocale,
      ),
    );
  }
}

/// Keeps authentication state below the stable MaterialApp root route.
/// This makes screen changes reliable on web, Android, and iOS.
class _AppShell extends StatefulWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const _AppShell({required this.locale, required this.onLocaleChanged});

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  static const _hasSeenOnboardingKey = 'has_seen_onboarding';

  bool _isAuthenticated = false;
  bool _hasSeenOnboarding = false;
  UserRole? _selectedRole;

  @override
  void initState() {
    super.initState();
    _loadOnboardingState();
  }

  Future<void> _loadOnboardingState() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool(_hasSeenOnboardingKey) ?? false;
    if (mounted && seen) setState(() => _hasSeenOnboarding = true);
  }

  Future<void> _completeOnboarding() async {
    setState(() => _hasSeenOnboarding = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedRole == null) {
      return StartScreen(
        onRoleSelected: (role) => setState(() => _selectedRole = role),
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
      );
    }
    if (_selectedRole == UserRole.admin) {
      if (!_isAuthenticated) {
        return LoginScreen(
          role: UserRole.admin,
          showCreateAccount: false,
          onAuthenticated: () => setState(() => _isAuthenticated = true),
          onBack: () => setState(() => _selectedRole = null),
        );
      }
      return AdminNavigation(
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
        onLogout: () => setState(() {
          _isAuthenticated = false;
          _selectedRole = null;
        }),
      );
    }
    if (_selectedRole == UserRole.technician) {
      if (!_isAuthenticated) {
        return LoginScreen(
          role: UserRole.technician,
          showCreateAccount: false,
          onAuthenticated: () => setState(() => _isAuthenticated = true),
          onBack: () => setState(() => _selectedRole = null),
        );
      }
      return TechnicianNavigation(
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
        onLogout: () => setState(() {
          _isAuthenticated = false;
          _selectedRole = null;
        }),
      );
    }
    if (!_hasSeenOnboarding) {
      return OnboardingScreen(onComplete: _completeOnboarding);
    }
    if (!_isAuthenticated) {
      return LoginScreen(
        onAuthenticated: () => setState(() => _isAuthenticated = true),
        onBack: () => setState(() => _selectedRole = null),
      );
    }
    return MainNavigation(
      locale: widget.locale,
      onLocaleChanged: widget.onLocaleChanged,
      onLogout: () => setState(() {
        _isAuthenticated = false;
        _selectedRole = null;
      }),
    );
  }
}
