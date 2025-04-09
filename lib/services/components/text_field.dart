import 'package:flutter/material.dart';

import 'package:task_manager_app/services/theme/colors.dart';

Widget AppTextField({
  double width = 250.0,
  double height = 95.0,
  double arabicHeight = 115.0,
  TextInputType textType = TextInputType.text,
  TextEditingController? textFormController,
  Color fillColor = primary,
  double textSize = 16,
  String hintText = '',
  Color hintColor = darkGrey,
  double hintSize = 16,
  int maxLetters = 11,
  bool needMax = false,
  bool needSuffix = false,
  IconData iconLead = Icons.add,
  IconData iconSuffix = Icons.add,
  Color iconColor = primary,
  double iconSize = 28,
  String labelText = '',
  Color labelColor = primary,
  double labelSize = 16,
  int inputLength = 8,
  bool isPassword = false,
  int minLines = 1,
  int maxLines = 1,
  Function()? function,
  Function()? onTapFunction,
  Function(String?)? onSave,
  Function(String)? onChangeFunction,
  Function()? validateFunction,
  Function(String)? onSubmit,
  dynamic focusNode,
  bool readOnly = false,
  bool isLength = false,
  bool isRegex = false,
  bool isMatch = false,
  bool collapse = false,
  bool isEmailRegex = false,
  TextAlignVertical textAlignVertical = TextAlignVertical.center,
  FloatingLabelBehavior labelFloating = FloatingLabelBehavior.auto,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTapFunction,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onFieldSubmitted: onSubmit,
        onChanged: onChangeFunction,
        onSaved: onSave,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          } else if (isEmailRegex == true && !validateEmail(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        focusNode: focusNode,
        keyboardType: textType,
        obscureText: isPassword,
        controller: textFormController,
        cursorColor: primary,
        minLines: minLines,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: textSize,
        ),
        textAlignVertical: textAlignVertical,
        maxLength: needMax == true ? maxLetters : null,
        decoration: InputDecoration(
          isCollapsed: collapse,
          floatingLabelBehavior: labelFloating,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: transparent,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: primary,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: red,
              width: 1.5,
            ),
          ),
          suffixIcon: needSuffix == true
              ? IconButton(
                  icon: Icon(
                    iconSuffix,
                    color: iconColor,
                    size: 28,
                  ),
                  onPressed: function,
                )
              : null,
          filled: true,
          fillColor: fillColor.withOpacity(0.2),
          prefixIcon: Icon(
            iconLead,
            color: iconColor,
            size: iconSize,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: hintSize,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelSize,
          ),
        ),
      ),
    );

bool validateEmail(String email) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}
