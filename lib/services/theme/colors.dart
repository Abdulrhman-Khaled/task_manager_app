import 'package:flutter/material.dart';

const primary = Color(0XFF6146C6);
const black = Color(0XFF000000);
const white = Color(0XFFffffff);
const red = Color(0XFFd93e46);
const green = Color(0XFF00cb71);
const orange = Color(0XFFff6d00);
const blue = Color(0XFF0741a8);
const lightGrey = Color(0XFFEEF4FF);
const darkGrey = Color(0XFF9E9E9F);
const transparent = Color.fromARGB(0, 0, 0, 0);

Map<int, Color> mainColorMap = {
  50: const Color.fromRGBO(97, 70, 198, .1),
  100: const Color.fromRGBO(97, 70, 198, .2),
  200: const Color.fromRGBO(97, 70, 198, .3),
  300: const Color.fromRGBO(97, 70, 198, .4),
  400: const Color.fromRGBO(97, 70, 198, .5),
  500: const Color.fromRGBO(97, 70, 198, .6),
  600: const Color.fromRGBO(97, 70, 198, .7),
  700: const Color.fromRGBO(97, 70, 198, .8),
  800: const Color.fromRGBO(97, 70, 198, .9),
  900: const Color.fromRGBO(97, 70, 198, 1),
};
MaterialColor mainMaterialColor = MaterialColor(0xFF6146C6, mainColorMap);
