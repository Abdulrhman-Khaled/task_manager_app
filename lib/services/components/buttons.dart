import 'package:flutter/material.dart';
import 'package:task_manager_app/services/theme/colors.dart';

Widget AppFilledButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = primary,
        Color buttonTextColor = white,
        double textSize = 16,
        String buttonText = "button text",
        Function()? function}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: function,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: textSize,
          ),
        ),
      ),
    );

Widget AppOutlineButton(
        {double width = 200.0,
        double height = 40.0,
        Color hoverColor = primary,
        Color buttonColor = primary,
        Color buttonTextColor = primary,
        double textSize = 16,
        String buttonText = "button text",
        Function()? function}) =>
    SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: hoverColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
                color: buttonColor, width: 2.5, style: BorderStyle.solid)),
        onPressed: function,
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor, fontSize: textSize),
        ),
      ),
    );
