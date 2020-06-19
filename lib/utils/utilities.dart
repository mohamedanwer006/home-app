import 'package:flutter/material.dart';

var designWidth = 375.0;
var designHight = 667.0;
bool isLarge(BuildContext context) {
  return MediaQuery.of(context).size.width > 768 ? true : false;
}

bool isSmall(BuildContext context) {
  return MediaQuery.of(context).size.width < 768 ? true : false;
}

double screenHight(BuildContext context, double hight) {
  return MediaQuery.of(context).size.height * (hight / designHight);
}

double screenWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * (width / designWidth);
}

Widget spaceHight(BuildContext context, double hight) {
  return SizedBox(
    height: screenHight(context, hight),
  );
}
