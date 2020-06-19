import 'package:flutter/material.dart';
import 'package:home_app/components/device_card.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/models/device_model.dart';
import 'package:home_app/screens/devices_page.dart';
import 'package:home_app/screens/room_edit.dart';
import 'package:home_app/services/api/device.dart';
import 'package:home_app/services/mqtt/mqtt_services.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/services/provider/devices_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/assets.dart';
import 'package:home_app/utils/utilities.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  static const String route = '/room';
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  DeviceServices _deviceServices = DeviceServices();
  // ApiServices _apiServices = ApiServices();
  MqttServices _mqttServices = MqttServices();
  ValueNotifier deviceNumber = ValueNotifier<int>(0);
  TextEditingController _name = TextEditingController();

  List<Device> devices = [];
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed(DevicesPage.route);
      },child: Icon(Icons.add,color: Theme.of(context).iconTheme.color,),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(22.0),
                bottomLeft: Radius.circular(22.0),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                      'Your living room has been connected with 3 devices',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 12)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.spaceAround,
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
                      Text('Temperatuer 25 C')
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        // alignment: WrapAlignment.spaceAround,
                        children: [
                          Consumer<ThemeChanger>(
                            builder: (context, value, child) =>
                                CircularIconButton(
                              height: 32,
                              width: 32,
                              color: value.darkTheme
                                  ? AppColors.iconsColorBackground3_dark
                                  : AppColors.iconsColorBackground2_light,
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
                          Text('Humidity 25 %'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MaterialButton(
                          onPressed: () {
                            for (Device device in devices) {
                              _mqttServices.toggleDevice(
                                  device.id, value ? 'on' : 'off');
                              setState(() {
                                device.value = value ? 'on' : 'off';
                              });
                            }
                            setState(() {
                              value = !value;
                            });
                          },
                          padding: EdgeInsets.all(0),
                          minWidth: 40,
                          height: 40,
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Consumer<CollectionProvider>(
                            builder:  (context, coll, child) => 
                            Hero(
                              tag: '${coll.collection.id}',
                                                        child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // color: AppColors.primaryColor_dark,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withAlpha(80),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.power_settings_new,
                                  color: value
                                      ? Colors.red
                                      : Theme.of(context).accentColor,
                                  size: 30,
                                )),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'Devices',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      thickness: 2,
                      height: 0,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ),
                  Expanded(
                    child: buildDevices(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Consumer<CollectionProvider>(
        builder: (context, value, child) => 
          Text(
          '${value.collection.name}',
          style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: MaterialButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.all(0),
          minWidth: 32,
          height: 32,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(16.0, 16.0)),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0 ,bottom: 12),
          child: RectIconButton(
              height: 28,
              width: 28,
              onPressed: () {
                Navigator.of(context).pushNamed(RoomEdit.route);
              },
              color: Colors.white,
              child: Icon(
                Icons.edit,
                size: 18,
              )),
        ),
      ],
    );
  }

  Widget buildDevices() {
    return Consumer<DeviceProvider>(
      builder: (context, deviceProvider, child) => FutureBuilder(
        future: deviceProvider.devices,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            devices = snapshot.data;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.54,
              child: GridView.builder(
                itemCount: devices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: isLarge(context) ? 1.2 : 1.4,
                    crossAxisCount: isLarge(context) ? 5 : 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Consumer<DeviceProvider>(
                      builder: (context, value, child) => DeviceCard(
                        name: '${devices[index].name}',
                        status: devices[index].value,
                        color: devices[index].value == 'on'
                            ? Theme.of(context).accentColor
                            : Colors.red,
                        onTap: () {
                          value.setDeviceNumber(index);
                          setState(() {
                            devices[index].value == 'on'
                                ? devices[index].value = 'off'
                                : devices[index].value = 'on';
                          });
                          _mqttServices.toggleDevice(devices[index].id,
                              (devices[index].value == 'off' ? 'off' : 'on'));
                        },
                        onLongPress: () {
                          deviceProvider.setDevice(devices[index]);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                // height:MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                          controller: _name,
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: AppColors.accentColor_dark,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'device name',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          )
                                          // onSaved: (val) => _name = val,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        RaisedButton(
                                          color: Colors.red,
                                          child: const Text('Close'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        RaisedButton(
                                          color: Theme.of(context).accentColor,
                                          child: const Text('Done'),
                                          onPressed: () {
                                            print(_name.text);
                                            value.setDeviceNumber(index);
                                            updateDeviceDetails(
                                                Device(name: _name.text));
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  void updateDeviceDetails(Device _device) async {
    var deviceProvider = Provider.of<DeviceProvider>(context);
    if (await _deviceServices.updateDevice(deviceProvider.device.id, _device)) {
      setState(() {
        devices[deviceProvider.deviceNumber].name = _device.name;
      });
      print("pin number:Updated");
    } else
      print('error');
  }
}
