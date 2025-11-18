import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/login.dart';
import 'package:work_hub/features/auth/screens/register.dart';
import 'package:work_hub/features/auth/screens/welcome.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_login_page.dart';
import 'package:work_hub/features/home_screen/home_page.dart';
import 'package:work_hub/features/home_screen/menuSheet/about_us.dart';
import 'package:work_hub/features/home_screen/menuSheet/ads_page.dart';
import 'package:work_hub/features/home_screen/menuSheet/contact_us.dart';
import 'package:work_hub/features/home_screen/menuSheet/privacy_page.dart';

class Approutes {
  static Map<String, WidgetBuilder> routes = {
    "welcome": (context) => const Welcome(),
    "register": (context) => const RegisterPage(),
    "login": (context) => const Login(),
    "home": (context) => const HomePage(),
    "privacy": (context) => const PrivacyPage(),
    "contactus": (context) => ContactUsPage(),
    "aboutus": (context) => const AboutUsPage(),
    "ads": (context) => const AdsPage(),
    "employerLogin": (context) => const EmployerLoginPage(),
    "employerDashboard": (context) => const EmployerDashboardPage(),
  };
}
