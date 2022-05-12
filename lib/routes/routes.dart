

import 'package:flutter/material.dart';
import 'package:lifewallpoc/main.dart';
import 'package:lifewallpoc/screens/Home/homepage.dart';
import 'package:lifewallpoc/screens/login.dart';

final Map<String, WidgetBuilder> routes = {

  Splash.routeName:(context) => Splash(),
  LoginPage.routeName:(context) => LoginPage(),
  HomePage.routeName:(context) => HomePage(),

};