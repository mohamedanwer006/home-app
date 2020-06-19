import 'package:flutter/material.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/models/collections.dart';
import 'package:home_app/models/weather.dart';
import 'package:home_app/screens/add_device.dart';
import 'package:home_app/screens/login_screen.dart';
import 'package:home_app/screens/room_page.dart';
import 'package:home_app/services/api/auth.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:provider/provider.dart';
import 'package:home_app/components/add_room_card.dart';
import 'package:home_app/components/room_card.dart';
import 'package:home_app/screens/add_room.dart';
import 'package:home_app/screens/settings.dart';
import 'package:home_app/services/api/device.dart';
import 'package:home_app/services/api/weather_services.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/services/provider/devices_provider.dart';
import 'package:home_app/services/provider/user_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/utils/assets.dart';
import 'package:home_app/utils/utilities.dart';
import 'dart:ui' as ui show ImageFilter;



class HomePage extends StatefulWidget {
  static const String route = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  bool switchValue = false;
  GlobalKey _globalKey;
  bool animate = false;
  DeviceServices _deviceServices = DeviceServices();
  WeatherServices weatherServices = WeatherServices();
  Weather weather = Weather();
  getweather() async {
    var data = await weatherServices.fetchData();
    setState(() {
      weather = data;
    });
  }

  AuthServices authServices = AuthServices();

  @override
  void initState() {
    getweather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        key: _globalKey,
        appBar: buildAppBar(context),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(22.0),
                    bottomLeft: Radius.circular(22.0),
                  ),
                ),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, bottom: 0, left: 10),
                      child: Consumer<UserProvider>(
                        builder: (context, value, child) => Text(
                          'Hello, ${value.user.name} ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text('Good to see you again',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: buildWeather(context),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'Scences',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    buildScences(context),
                    Container(
                      padding: EdgeInsets.only(top: 0, left: 10),
                      child: Text(
                        'Rooms',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    buildRooms(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
          child: RectIconButton(
              height: 32,
              width: 32,
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    var width = MediaQuery.of(context).size.width;
                    var height = MediaQuery.of(context).size.height;
                    double buttonSize = 63;
                    return addDialogWidget(context, width, height, buttonSize);
                  },
                );
              },
              color: Colors.white,
              child: Image.asset(
                Assets.menuIcon,
                scale: 1.5,
              )),
        ),
      ],
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: CircularIconButton(
            height: 32,
            width: 32,
            color: Colors.white,
            child: Hero(
              tag: 'profile',
              child: Consumer<UserProvider>(
                builder: (context, value, child) => Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(16.0, 16.0)),
                    image: DecorationImage(
                      image: value.user != null
                          ? NetworkImage('${value.user.picture}')
                          : const NetworkImage(
                              'https://celebmafia.com/wp-content/uploads/2017/04/scarlett-johansson-glamour-magazine-mexico-april-2017-issue-6.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            onPressed: _setting,
          ),
        ),
      ),
    );
  }

  Widget addDialogWidget(
      BuildContext context, double width, double height, double buttonSize) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: GestureDetector(
          onTap: () {
            animate = false;
            Navigator.pop(context);
          },
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0x57ffffff),
            ),
            child: Center(
              child: Stack(
                children: [
                  Center(
                      child: CircularIconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                    color: Colors.white,
                    height: buttonSize,
                    width: buttonSize,
                  )),
                  Positioned(
                      top: height * 0.5 - (buttonSize * 2),
                      left: width * 0.5 - (buttonSize / 2),
                      child: Center(
                          child: CircularIconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddDevicePage.route);
                        },
                        child: Center(
                            child: Text(
                          'Device',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: AppColors.textColor_light),
                        )),
                        color: Colors.white,
                        height: buttonSize,
                        width: buttonSize,
                      ))),
                  Positioned(
                      top: height * 0.5 - (buttonSize / 2),
                      left: width * 0.5 - (buttonSize * 2),
                      child: Center(
                          child: CircularIconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddRoomPage.route);
                        },
                        child: Center(
                            child: Text(
                          'Room',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: AppColors.textColor_light),
                        )),
                        color: Colors.white,
                        height: buttonSize,
                        width: buttonSize,
                      ))),
                  Positioned(
                      top: height * 0.5 - (buttonSize / 2),
                      right: width * 0.5 - (buttonSize * 2),
                      child: Center(
                          child: CircularIconButton(
                        onPressed: () async {
                          authServices.logOut().then((value) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginPage()),
                                (Route<dynamic> route) => false);
                          }).catchError((onError) {
                            print(onError);
                          });
                        },
                        child: Center(
                            child: Text(
                          'logOut',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: AppColors.textColor_light),
                        )),
                        color: Colors.white,
                        height: buttonSize,
                        width: buttonSize,
                      ))),
                  Positioned(
                      bottom: height * 0.5 - (buttonSize * 2),
                      left: width * 0.5 - (buttonSize / 2),
                      child: Center(
                          child: CircularIconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Center(child: Text('Sorry🥺')),
                              children: [
                                Center(
                                    child: Text(
                                  ' This feature not work at this time',
                                  style: Theme.of(context).textTheme.subtitle2,
                                )),
                              ],
                            ),
                          );
                        },
                        child: Center(
                            child: Text(
                          'Scence',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: AppColors.textColor_light),
                        )),
                        color: Colors.white,
                        height: buttonSize,
                        width: buttonSize,
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeather(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 66.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            // alignment: WrapAlignment.end,
            children: [
              Consumer<ThemeChanger>(
                builder: (context, value, child) => CircularIconButton(
                  height: 32,
                  width: 32,
                  color: value.darkTheme
                      ? AppColors.iconsColorBackground2_dark
                      : AppColors.iconsColorBackground3_light,
                  child: Image.asset(
                    Assets.temperatureIcon,
                    color: value.darkTheme
                        ? AppColors.iconsColor_dark
                        : AppColors.iconsColorBackground2_dark,
                    scale: 1.5,
                  ),
                  onPressed: null,
                ),
              ),
              Text(
                  'Temperatuer ${weather.temp == null ? '' : weather.temp.value.floor()} C')
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              // alignment: WrapAlignment.end,
              children: [
                Consumer<ThemeChanger>(
                  builder: (context, value, child) => CircularIconButton(
                    height: 32,
                    width: 32,
                    color: value.darkTheme
                        ? AppColors.iconsColorBackground3_dark
                        : AppColors.iconsColorBackground3_light,
                    child: Image.asset(
                      Assets.humidityIcon,
                      color: value.darkTheme
                          ? AppColors.iconsColor_dark
                          : AppColors.iconsColorBackground3_dark,
                      scale: 1.5,
                    ),
                    onPressed: null,
                  ),
                ),
                Text(
                    'Humidity ${weather.humidity == null ? '' : weather.humidity.value.floor()} %')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRooms(BuildContext context) {
    return Consumer<CollectionProvider>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.collections,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Collection> rooms = snapshot.data;
              return Container(
                height: MediaQuery.of(context).size.height * 0.42,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: rooms.length + 1,
                  itemBuilder: (context, index) {
                    //*check if index is equal to the last item in the list+1
                    if (index == snapshot.data.length) {
                      return AddRoomCard(
                        onTap: _addRoom,
                      );
                    } else
                      return RoomCard(
                        onPreessed: () {
                          Provider.of<DeviceProvider>(context).setDevices(
                              _deviceServices.getDevicesByIds(
                                  snapshot.data[index].devices));
                          Provider.of<CollectionProvider>(context)
                              .setCollection(snapshot.data[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomPage(),
                            ),
                          );
                        },
                        room: rooms[index],
                      );
                  },
                ),
              );
            } else
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).backgroundColor),
                  ),
                ),
              );
          },
        );
      },
    );
  }

  Widget buildScences(BuildContext context) {
    return Container(
      height: isLarge(context) ? 150 : 100,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: scences.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: MaterialButton(
            padding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Center(child: Text('Sorry🥺')),
                  children: [
                    Center(
                        child: Text(
                      ' This feature not work at this time',
                      style: Theme.of(context).textTheme.subtitle2,
                    )),
                  ],
                ),
              );
            },
            child: Container(
              width: isLarge(context) ? 300 : 150,
              height: isLarge(context) ? 150 : 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: AssetImage(scences[index].imagePath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: scences[index].shadowColor,
                    offset: Offset(0, 0),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                  child: Text(
                'Night mode',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }

  void _setting() {
    Navigator.pushNamed(context, SettingsPage.route);
  }

  void _addRoom() {
    Navigator.pushNamed(context, AddRoomPage.route);
  }
}

class Scences {
  String imagePath;
  Color shadowColor;
  Scences({
    this.imagePath,
    this.shadowColor,
  });
}

List<Scences> scences = [
  Scences(imagePath: Assets.nightImage, shadowColor: Color(0xFF1C4276)),
  Scences(imagePath: Assets.morningImage, shadowColor: Color(0xFFD2C6BD)),
  Scences(imagePath: Assets.eveningImage, shadowColor: Color(0xFF7A4547)),
];
