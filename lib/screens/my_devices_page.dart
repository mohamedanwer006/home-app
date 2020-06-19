import 'package:flutter/material.dart';
import 'package:home_app/components/device_card.dart';
import 'package:home_app/models/device_model.dart';
import 'package:home_app/services/api/device.dart';
import 'package:home_app/services/mqtt/mqtt_services.dart';
import 'package:home_app/services/provider/devices_provider.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/utilities.dart';
import 'package:provider/provider.dart';

class MyDevicesPage extends StatefulWidget {
  static const route = '/myDevices';
  @override
  _MyDevicesPageState createState() => _MyDevicesPageState();
}

class _MyDevicesPageState extends State<MyDevicesPage> {
  int selected = 0;
  DeviceServices _deviceServices = DeviceServices();
  MqttServices _mqttServices=MqttServices();
  List<Device> devices = [];
  GlobalKey key = GlobalKey();
  
 getDevices()async{
    return await _deviceServices.getDevices();
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Devices',
          style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),
        ),
      ),
      body: Consumer<ThemeChanger>(
        builder: (context, theme, child) => Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:buildDevices() 
              ),
            ),
          ],
        ),
      ),
    );
  }
//Todo:fix when resize browser in desktop Futurebuilder called many times
  Widget buildDevices() {
    return Consumer<DeviceProvider>(
      builder: (context, deviceProvider, child) => FutureBuilder(
        future:getDevices() ,
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
                          onLongPress: null),
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
}
