import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifewallpoc/provider/dataprodivider.dart';
import 'package:lifewallpoc/routes/routes.dart';
import 'package:lifewallpoc/screens/Dashboard/dashboard.dart';
import 'package:lifewallpoc/screens/Dashboard/Tabs/all_services.dart';
import 'package:lifewallpoc/screens/login.dart';
import 'package:provider/provider.dart';
import 'constant/customcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/string.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Dataprovider>(
      create: (context) => Dataprovider(),
    ),
  ], child: MyApp()));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeWallPoc',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: Splash.routeName,
      //initial page of this application
      routes: routes, // maintain all pages with route navigation
    );
  }
}

class Splash extends StatefulWidget {
  static String routeName = splash;

  @override
  State<StatefulWidget> createState() {
    return _splash();
  }
}

class _splash extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool data;

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: new Duration(seconds: 2), vsync: this); //default navigation after 2 second
    animationController.repeat();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context)
        .size
        .width; // device width in percentage calculation
    double device_height = MediaQuery.of(context)
        .size
        .height; // device height in percentage calculation
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: device_width,
          height: device_height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Primarycolor,
                    Primarycolor,
                  ])),
          child: const SizedBox(),


        ),
      ),
    );
  }

  Future<bool> getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loginstatus');
  }

  _getdata() async{
    data = await getBoolValuesSF() ?? false;
    //data = true;
    Timer(Duration(seconds:3),
            () => data==true ?    Navigator.of(context).pushNamed(Dashboard.routeName) :
        Navigator.of(context).pushNamed(LoginPage.routeName)
    );
  }

}





