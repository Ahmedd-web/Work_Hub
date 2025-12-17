import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/employer_session.dart';
import 'package:work_hub/core/routes.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/auth/screens/welcome.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/home_screen/home_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/networking/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        AndroidProvider.debug, // change to playIntegrity for release
    appleProvider:
        AppleProvider.debug, // change to appAttest/deviceCheck for release
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? localeValue;
  ThemeMode themeModeValue = ThemeMode.light;
  final GlobalKey<NavigatorState> navigatorKeyValue =
      GlobalKey<NavigatorState>();
  static const localePrefKeyValue = 'preferredlocale';
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    loadInitialLocale();
  }

  ThemeMode get themeMode => themeModeValue;

  Future<void> loadInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCodeValue = prefs.getString(localePrefKeyValue);
    Locale? initialLocaleValue;

    if (savedCodeValue != null && savedCodeValue.isNotEmpty) {
      initialLocaleValue = resolveSupportedLocale(Locale(savedCodeValue));
    } else {
      final deviceLocaleValue =
          WidgetsBinding.instance.platformDispatcher.locale;
      initialLocaleValue = resolveSupportedLocale(deviceLocaleValue);
    }

    if (initialLocaleValue != null && mounted) {
      setState(() => localeValue = initialLocaleValue);
    }
  }

  Locale? resolveSupportedLocale(Locale? localeInput) {
    if (localeInput == null) return null;
    for (final supportedValue in S.delegate.supportedLocales) {
      if (supportedValue.languageCode == localeInput.languageCode) {
        return Locale(supportedValue.languageCode);
      }
    }
    return null;
  }

  Future<void> setLocale(Locale localeInput) async {
    final normalizedValue = resolveSupportedLocale(localeInput);
    if (!mounted || normalizedValue == null) return;
    setState(() => localeValue = normalizedValue);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(localePrefKeyValue, normalizedValue.languageCode);
  }

  void setThemeMode(ThemeMode modeValue) {
    if (!mounted) return;
    setState(() => themeModeValue = modeValue);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeValue,
      navigatorKey: navigatorKeyValue,
      locale: localeValue,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routes: Approutes.routes,
      home:
          showSplash
              ? SplashMahanti(
                onFinish: () => setState(() => showSplash = false),
              )
              : const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshotValue) {
        if (snapshotValue.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final isAuthenticatedValue = snapshotValue.data != null;
        if (!isAuthenticatedValue) {
          return const Welcome();
        }
        NotificationService.instance.ensurePermissionsAndSaveToken(
          FirebaseAuth.instance.currentUser!.uid,
        );
        return FutureBuilder<bool>(
          future: EmployerSession.isEmployer(),
          builder: (context, employerSnapshotValue) {
            if (!employerSnapshotValue.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return employerSnapshotValue.data == true
                ? const EmployerDashboardPage()
                : const HomePage();
          },
        );
      },
    );
  }
}

class SplashMahanti extends StatefulWidget {
  const SplashMahanti({super.key, this.onFinish});

  final VoidCallback? onFinish;

  @override
  State<SplashMahanti> createState() => SplashMahantiState();
}

class SplashMahantiState extends State<SplashMahanti>
    with SingleTickerProviderStateMixin {
  late AnimationController controllerValue;
  late Animation<double> opacityValue;
  late Animation<double> scaleValue;
  Timer? timerValue;

  @override
  void initState() {
    super.initState();
    controllerValue = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    opacityValue = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controllerValue, curve: Curves.easeOut));
    scaleValue = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: controllerValue, curve: Curves.easeOutBack),
    );
    controllerValue.forward();

    timerValue = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      widget.onFinish?.call();
    });
  }

  @override
  void dispose() {
    timerValue?.cancel();
    controllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.splash, fit: BoxFit.cover),
          Center(
            child: AnimatedBuilder(
              animation: controllerValue,
              builder: (context, childValue) {
                return Opacity(
                  opacity: opacityValue.value,
                  child: Transform.scale(
                    scale: scaleValue.value,
                    child: childValue,
                  ),
                );
              },
              child: const Text(
                'مهنتي',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
