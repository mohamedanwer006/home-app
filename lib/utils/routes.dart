import 'package:flutter/material.dart';
import 'package:home_app/main.dart';
import 'package:home_app/screens/about_page.dart';
import 'package:home_app/screens/add_device.dart';
import 'package:home_app/screens/add_room.dart';
import 'package:home_app/screens/devices_page.dart';
import 'package:home_app/screens/home_page.dart';
import 'package:home_app/screens/login_screen.dart';
import 'package:home_app/screens/register_page.dart';
import 'package:home_app/screens/room_edit.dart';
import 'package:home_app/screens/room_page.dart';
import 'package:home_app/screens/rooms_page.dart';
import 'package:home_app/screens/my_devices_page.dart';
import 'package:home_app/screens/profile_edit_page.dart';
import 'package:home_app/screens/settings.dart';

final routes = {
  '/': (BuildContext context) => HomeApp(),
  LoginPage.route: (BuildContext context) => LoginPage(),
  RegisterPage.route: (BuildContext context) => RegisterPage(),
  HomePage.route: (BuildContext context) => HomePage(),
  RoomPage.route: (BuildContext context) => RoomPage(),
  RoomEdit.route: (BuildContext context) => RoomEdit(),
  SettingsPage.route: (BuildContext context) => SettingsPage(),
  AddRoomPage.route: (BuildContext context) => AddRoomPage(),
  AboutPage.route: (BuildContext context) => AboutPage(),
  DevicesPage.route: (BuildContext context) => DevicesPage(),
  RoomsPage.route: (BuildContext context) => RoomsPage(),
  ProfileEditPage.route: (BuildContext context) => ProfileEditPage(),
  MyDevicesPage.route: (BuildContext context) => MyDevicesPage(),
  AddDevicePage.route: (BuildContext context) => AddDevicePage(),
  
};
