import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_hub/core/routes.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/auth/screens/welcome.dart';
import 'package:work_hub/features/home_screen/home_page.dart';
import 'package:work_hub/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.light;
  static const _localePrefKey = 'preferred_locale';

  @override
  void initState() {
    super.initState();
    _loadInitialLocale();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_localePrefKey);
    Locale? initialLocale;

    if (savedCode != null && savedCode.isNotEmpty) {
      initialLocale = _resolveSupportedLocale(Locale(savedCode));
    } else {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      initialLocale = _resolveSupportedLocale(deviceLocale);
    }

    if (initialLocale != null && mounted) {
      setState(() => _locale = initialLocale);
    }
  }

  Locale? _resolveSupportedLocale(Locale? locale) {
    if (locale == null) return null;
    for (final supported in S.delegate.supportedLocales) {
      if (supported.languageCode == locale.languageCode) {
        return Locale(supported.languageCode);
      }
    }
    return null;
  }

  Future<void> setLocale(Locale locale) async {
    final normalized = _resolveSupportedLocale(locale);
    if (!mounted || normalized == null) return;
    setState(() => _locale = normalized);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localePrefKey, normalized.languageCode);
  }

  void setThemeMode(ThemeMode mode) {
    if (!mounted) return;
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final bool isAuthenticated = snapshot.data != null;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,
          locale: _locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routes: Approutes.routes,
          home:
              snapshot.connectionState == ConnectionState.waiting
                  ? const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  )
                  : (isAuthenticated ? const HomePage() : const Welcome()),
        );
      },
    );
  }
}
