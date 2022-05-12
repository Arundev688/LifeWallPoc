import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:lifewallpoc/constant/customcolor.dart';
import 'package:lifewallpoc/constant/string.dart';
import 'package:lifewallpoc/utils/KommunicateFlutterPlugin.dart';
import 'package:lifewallpoc/widget/primarybutton.dart';
import '../login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String routeName = homepage;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String getPlatformName() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "iOS";
    } else {
      return "NOP";
    }
  }

  String getCurrentTime() {
    return DateFormat('HH:mm:ss').format(DateTime.now());
  }

  int getTimeStamp() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  void fetchUserDetails(String userid) {
    try {
      KommunicateFlutterPlugin.fetchUserDetails(userid)
          .then((value) => print("User details fetched: " + value));
    } on Exception catch (e) {
      print("Fetching user details error : " + e.toString());
    }
  }

  @override
  void initState() {
    try {} catch (e) {}
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop as Future<bool> Function(),
      child: Scaffold(
            appBar: AppBar(
              backgroundColor: Primarycolor,
              title: const Text('Welcome to LifeWall'),
              automaticallyImplyLeading: false,
               actions: [
                IconButton(
                    onPressed: () {
                      showGeneralDialog(
                        barrierDismissible: false,
                        context: context,
                        barrierColor: Colors.black54,
                        // space around dialog
                        transitionDuration: Duration(milliseconds: 800),
                        transitionBuilder: (context, a1, a2, child) {
                          return ScaleTransition(
                              scale: CurvedAnimation(
                                  parent: a1,
                                  curve: Curves.elasticOut,
                                  reverseCurve: Curves.easeOutCubic),
                              child: _buildDialogContent(context));
                        },
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return null;
                        } as Widget Function(
                            BuildContext, Animation<double>, Animation<double>),
                      );
                    },
                    icon: Icon(Icons.logout_sharp))
              ],
            ),
            body: Container(),
            floatingActionButton: FloatingActionButton(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Image.asset(
                  'asset/image/chat.png',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Primarycolor,
              onPressed: () {
                KommunicateFlutterPlugin.openConversations();
              },
            ),
          ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: device_width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
            top: device_height * 0.02,
            left: device_width * 0.05,
            right: device_width * 0.05,
            bottom: device_height * 0.01), // spacing inside the box
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: device_width * 0.06,
              backgroundColor: LightGray,
              child: Icon(
                Icons.logout,
                color: SecondaryDark,
                size: device_height * 0.04,
              ),
            ),
            SizedBox(height: device_height * 0.03),
            Text(
              'Logout Alert',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: device_height * 0.03),
            Text(
              'Do you want to logout this application?',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: device_height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                  width: device_width * 0.32,
                  height: device_height * 0.05,
                  press: () {
                    Navigator.of(context).pop();
                  },
                  text: 'No',
                  mystyle: TextStyle(fontSize: 15, color: Whitecolor),
                ),
                PrimaryButton(
                  width: device_width * 0.32,
                  height: device_height * 0.05,
                  press: () {
                    addStringToSF(context);
                  },
                  text: 'Yes',
                  mystyle: TextStyle(fontSize: 15, color: Whitecolor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {


  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  addStringToSF(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
