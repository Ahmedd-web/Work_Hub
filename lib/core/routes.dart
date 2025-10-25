
import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/login.dart';
import 'package:work_hub/features/auth/screens/register.dart';
import 'package:work_hub/features/auth/screens/welcome.dart';
import 'package:work_hub/features/home_screen/home_page.dart';


class Approutes {


    static Map<String, WidgetBuilder> routes = {
    "welcome": (context) => const Welcome(),
    "register": (context) => const RegisterPage(),
    "login": (context) => const Login(),
    "home": (context) => const HomePage(),

  };

  
}