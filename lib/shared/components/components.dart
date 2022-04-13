
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_auth/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextButton(
    {required String text,
      required Function() onPressed,
      Color color = Colors.black,}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
Widget defaultTextField({
  required TextEditingController controller,
  required FormFieldValidator<String>? validator,
  required TextInputType inputType,
  required String label,
  required IconData prefix,
  Function()? onTap,
  Function()? suffixPressed,
  Function(String value)? onSubmit,
  Function(String value)? onChanged,
  bool isClickable = true,
  bool isPassword = false,
  IconData? suffix,
}) =>
    Container(
      height: 70.0,
      padding: EdgeInsets.only(right: 10,left: 10,bottom: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: primarySwatch)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: primarySwatch)),
          labelText: label,
          focusColor: primarySwatch,
          labelStyle: TextStyle(color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(
            prefix,
            color: primarySwatch,
          ),
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
              : null,
        ),
      ),
    );

Widget defaultButton({
  required Function() onPressed,
  required String text,
  double width = double.infinity,
}) =>

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: primarySwatch,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) {
    return false;
  },
);

void showToast({
  required String message,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor (ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS: color= Colors.green;
    break;
    case ToastStates.ERROR: color= Colors.red;
    break;
    case ToastStates.WARNING: color= Colors.amber;
    break;
  }
  return color;
}
