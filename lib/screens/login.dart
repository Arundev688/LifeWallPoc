


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifewallpoc/constant/AppConfig.dart';
import 'package:lifewallpoc/constant/customcolor.dart';
import 'package:lifewallpoc/constant/string.dart';
import 'package:lifewallpoc/provider/dataprodivider.dart';
import 'package:lifewallpoc/screens/Dashboard/dashboard.dart';
import 'package:lifewallpoc/utils/KommunicateFlutterPlugin.dart';
import 'package:lifewallpoc/widget/alertdialog.dart';
import 'package:lifewallpoc/widget/primarybutton.dart';
import 'package:lifewallpoc/widget/primaryformfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  static String routeName = loginroute;

  @override
  State<StatefulWidget> createState() {
    return new _login();
  }
}

class _login extends State<LoginPage>{

  bool showpassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  bool loading = false;
  var _snackBar1;
  String fail_msg;

  @override
  void initState() {
    super.initState();
    showpassword = false;
  }


  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Primarycolor,
        automaticallyImplyLeading: false,
        title: const Text('LifeWall POC'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: device_width,
              height: device_height,
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formKey, //formkey is used for textfield  validation
                    child: Column(
                      children: [
                        PrimaryFormfield(
                          controller: namecontroller, //controll is user to save the textfield value
                          width: device_width,
                          pswvisible: false,
                          maxlines: 1,
                          auto: false,
                          align: TextAlign.start,
                          icon: Icon(Icons.perm_identity_rounded,
                              color: Colors.grey),
                          label: 'Username',
                          type: TextInputType.text,
                          action: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter correct username";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: device_height * 0.05),
                        PrimaryFormfield(
                          controller: passwordcontroller,
                          width: device_width,
                          pswvisible: !showpassword,
                          auto: false,
                          maxlines: 1,
                          align: TextAlign.start,
                          suffixicon: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              showpassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.green[800],
                            ),
                            onPressed: () {
                              setState(() {
                                showpassword =
                                !showpassword;
                              });
                            },
                          ),
                          icon: const Icon(
                            Icons.vpn_key_outlined,
                            color: Colors.grey,
                          ),
                          label: 'Password',
                          type: TextInputType.text,
                          action: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter correct password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: device_height * 0.08),
                    loading == true  ?  Center(child: CircularProgressIndicator(color: Primarycolor,)) :  Align(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: device_width * 0.6,
                      height: device_height * 0.058,
                      press: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          getLogin();
                          addBoolToSF("loginstatus", true);
                        }
                      },
                      text:'Sign in',
                      mystyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getLogin() async {

    dynamic user = {
      'userId': namecontroller.text,
      'password': passwordcontroller.text,
      'appId': AppConfig.APP_ID
    };


    await Provider.of<Dataprovider>(context, listen: false)
        .getlogin(namecontroller.text, passwordcontroller.text)
        .then((value) {
      if(value.result.status == "Successfully logged in"){
        Navigator.of(context).pushNamed(Dashboard.routeName);
      } else {
        String val = value.result.status;
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(val),
        ));
        setState(() {
          loading = false;
        });
      }
    });
  }

  addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  void getLogin2() async {
    dynamic user = {
      'userId': namecontroller.text,
      'password': passwordcontroller.text,
      'appId': AppConfig.APP_ID
    };

    KommunicateFlutterPlugin.login(user).then((result) {
      setState(() {
        loading = false;
      });

      Navigator.of(context).pushNamed(Dashboard.routeName);
    }).catchError((error) {
      print("Login failed : " + error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter user name & password'),
      ));
      setState(() {
        loading = false;
      });

    });
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

}





/*
class LoginPage extends StatelessWidget{

  bool showpassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  bool loading = false;


  void loginUser(context) {
    dynamic user = {
      'userId': namecontroller.text,
      'password': passwordcontroller.text,
      'appId': AppConfig.APP_ID
    };

    KommunicateFlutterPlugin.login(user).then((result) {
      loading = false;
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((error) {
      print("Login failed : " + error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter user name & password'),
      ));
      loading = false;
    });
  }





  @override
  Widget build(BuildContext context) {

    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

*/
/*
    try {
      KommunicateFlutterPlugin.isLoggedIn().then((value) {
        print("Logged in : " + value.toString());
        if (value) {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    } on Exception catch (e) {
      print("isLogged in error : " + e.toString());
    }*//*


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Primarycolor,
        title: const Text('LifeWall POC'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: device_width,
            height: device_height,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey, //formkey is used for textfield  validation
                  child: Column(
                    children: [
                      PrimaryFormfield(
                        controller: namecontroller, //controll is user to save the textfield value
                        width: device_width,
                        pswvisible: false,
                        maxlines: 1,
                        auto: false,
                        align: TextAlign.start,
                        icon: Icon(Icons.perm_identity_rounded,
                            color: Colors.grey),
                        label: 'Username',
                        type: TextInputType.text,
                        action: TextInputAction.next,
                      ),
                      SizedBox(height: device_height * 0.05),
                      PrimaryFormfield(
                        controller: passwordcontroller,
                        width: device_width,
                        pswvisible: false,
                        auto: false,
                        maxlines: 1,
                        align: TextAlign.start,
                        suffixicon: IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(
                             Icons.visibility,
                            color: Primarycolor,
                          ),
                          onPressed: () {

                          },
                        ),
                        icon: Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.grey,
                        ),
                        label: 'Password',
                        type: TextInputType.text,
                        action: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: device_height * 0.08),
                loading == true  ?  Center(child: CircularProgressIndicator(color: Primarycolor,)) :  Align(
                  alignment: Alignment.center,
                  child: PrimaryButton(
                    width: device_width * 0.6,
                    height: device_height * 0.058,
                    press: () {
                      loginUser(context);
                      loading = true;
                    },
                    text: 'Sign in',
                    mystyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
*/

