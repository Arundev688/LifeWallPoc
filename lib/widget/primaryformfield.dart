//custom TextFormField

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifewallpoc/constant/customcolor.dart';



class PrimaryFormfield extends StatelessWidget {
  final String label;
  final String text;
  final String error;
  final TextInputType type;
  final Icon icon;
  final TextEditingController controller;
  final TextInputAction action;
  final int length;
  final FormFieldValidator<String> validator;
  final bool auto;
  final FormFieldSetter<String> save;
  final ValueChanged<String> onChanged;
  final String hint;
  final IconButton suffixicon;
  final bool pswvisible;
  final String hintlength;
  final TextAlign align;
  final String errorname;
  final double width;
  final double height;
  final int maxlines;

  const PrimaryFormfield({
    Key key,
    this.label,
    this.text,
    this.error,
    this.type,
    this.icon,
    this.controller,
    this.action,
    this.length,
    this.validator,
    this.auto,
    this.save,
    this.onChanged,
    this.hint,
    this.suffixicon,
    this.pswvisible,
    this.hintlength,
    this.align,
    this.errorname,
    this.width,
    this.height,
    this.maxlines,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(primaryColor:SecondaryDark),//used for cursor & active TextFormField boarder color
      child:Container(
        width: width,
        height: height,
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          //  textInputAction: action,
          maxLength: length,
          maxLines: maxlines,
          obscureText: pswvisible,
          validator: validator, //formfield validation
          onChanged: onChanged,
          onSaved: save, //save textformfield value
          textAlignVertical: TextAlignVertical.center,
          textAlign: align,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(16.0,16.0,16,5.0),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.transparent), borderRadius: BorderRadius.circular(30)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:SecondaryDark), borderRadius: BorderRadius.circular(30)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.transparent), borderRadius: BorderRadius.circular(30)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            filled: true,
            fillColor: LightGray,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black54, fontSize: 15.0,fontWeight: FontWeight.w600),
            prefixIcon: icon,
            suffixIcon: suffixicon,
            errorStyle: TextStyle(fontSize:12,color: Colors.red),
            hintText: hint,
            counterText: hintlength,
            hintStyle: TextStyle(color: Colors.black54,fontSize:17.0),
          ),
        ),
      ),
    );
  }
}