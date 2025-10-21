
import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/register.dart';
import 'package:work_hub/features/auth/screens/welcome.dart';


class Approutes {


    static Map<String, WidgetBuilder> routes = {
    "welcome": (context) => const Welcome(),
    "login": (context) => const RegisterPage(),
  };

  
}