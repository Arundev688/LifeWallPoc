

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifewallpoc/constant/customcolor.dart';
import 'package:lifewallpoc/constant/string.dart';
import 'package:lifewallpoc/screens/Dashboard/Tabs/all_services.dart';
import 'package:lifewallpoc/widget/alertdialog.dart';
import 'package:lifewallpoc/widget/primarybutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import 'Tabs/my_schedules.dart';

class Dashboard extends StatefulWidget{
  static String routeName = dashboard;

  @override
  DashboardState createState() => DashboardState();


}

class DashboardState extends State<Dashboard>{

  @override
  Widget build(BuildContext context) {

    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        initialIndex: 0,
        length:2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Primarycolor,
            shadowColor: Secondarylight,
            elevation: 5,
            centerTitle: true,
            title: const Text(
              "Welcome to LifeWall",
              style: TextStyle(
                  fontSize: 18, color: Whitecolor, fontWeight: FontWeight.bold),
            ),
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
                            child: CustomAlertDialog(
                              title: "Logout Alert",
                              subtitle: "Do you want to logout from the app?",
                              btn_yes: "Yes",
                              btn_no: "No",
                              icon: Icon(
                                Icons.logout,
                                color: SecondaryDark,
                                size: device_height * 0.04,
                              ),
                              yes_press:() {
                                addStringToSF(context);
                              },
                              no_press: (){
                                Navigator.of(context).pop();
                              },
                            ),
                        );
                      },
                      pageBuilder: (BuildContext context, Animation animation,
                          Animation secondaryAnimation) {
                        return null;
                      },
                    );

                  },
                  icon: Icon(Icons.logout_sharp))
            ],
            bottom: PreferredSize(
              child: Column(
                children: [
                  Container(
                    color: Whitecolor,
                    height: 1.0,
                  ),
                  const TabBar(
                    indicatorColor: Whitecolor,
                    indicatorWeight: 3,
                    tabs: [
                      Tab(text: 'MySchedules'),
                      Tab(text: 'All Services'),
                    ],
                  )
                ],
              ),
              preferredSize: Size.fromHeight(device_height * 0.05),
            ),
          ),
          body: TabBarView(
            children: [
              MySchedules(),
              AllServices(),
            ],
          ),
        ),
      ),
    );
  }

  
  



  Future<bool> _onWillPop() {

    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

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
            child: CustomAlertDialog(
              title: "Exit Alert",
              subtitle: "Do you want to exit the app?",
              btn_yes: "Yes",
              btn_no: "No",
              icon: Icon(
                Icons.exit_to_app,
                color: SecondaryDark,
                size: device_height * 0.04,
              ),
              yes_press:() {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              no_press: (){
                Navigator.of(context).pop(false);
              },
            ));
      },
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return null;
      },
    );
  }



  addStringToSF(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}