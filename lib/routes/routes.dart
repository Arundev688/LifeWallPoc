

import 'package:flutter/material.dart';
import 'package:lifewallpoc/main.dart';
import 'package:lifewallpoc/screens/Dashboard/dashboard.dart';
import 'package:lifewallpoc/screens/Dashboard/Tabs/all_services.dart';
import 'package:lifewallpoc/screens/login.dart';

final Map<String, WidgetBuilder> routes = {

  Splash.routeName:(context) => Splash(),
  LoginPage.routeName:(context) => LoginPage(),
  Dashboard.routeName:(context) => Dashboard(),

};