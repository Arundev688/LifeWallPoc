//default button with primarycolor

import 'package:flutter/material.dart';
import 'package:lifewallpoc/constant/customcolor.dart';



class PrimaryButton extends StatelessWidget {
  final String text;
  final Function press;//click event
  final TextStyle mystyle;
  final double width;
  final double height;

  const PrimaryButton({
    Key key,
    this.text,
    this.press,
    this.mystyle,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Secondarycolor,
        splashColor: Secondarylight,
        onPressed:press as void Function(),
        child: Text(
          text,
          style: mystyle,//user for button text style
        ),
      ),
    );
  }
}
