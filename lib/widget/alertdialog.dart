





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifewallpoc/constant/customcolor.dart';
import 'package:lifewallpoc/widget/primarybutton.dart';

class CustomAlertDialog extends StatelessWidget{

  final String title;
  final String subtitle;
  final String btn_yes;
  final String btn_no;
  final Function yes_press;
  final Function no_press;
  final Icon icon;

  const CustomAlertDialog({Key key, this.title, this.subtitle, this.btn_yes, this.btn_no, this.yes_press, this.no_press, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return  Center(
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
                child: icon
            ),
            SizedBox(height: device_height * 0.03),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: device_height * 0.03),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
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
                  press: no_press,
                  text: btn_no,
                  mystyle: TextStyle(fontSize: 15, color: Whitecolor),
                ),
                PrimaryButton(
                  width: device_width * 0.32,
                  height: device_height * 0.05,
                  press: yes_press,
                  text: btn_yes,
                  mystyle: TextStyle(fontSize: 15, color: Whitecolor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }







}