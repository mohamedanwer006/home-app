import 'package:flutter/material.dart';
import 'package:home_app/components/list_device_card.dart';
import 'package:home_app/components/show_loading.dart';
import 'package:home_app/models/device_model.dart';
import 'package:home_app/services/api/collection.dart';
import 'package:home_app/services/api/device.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/services/provider/devices_provider.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/assets.dart';
import 'package:provider/provider.dart';

class DevicesPage extends StatefulWidget {
  static const route = '/devices';
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  int selected = 0;
  DeviceServices _deviceServices = DeviceServices();
  CollectionServices _collectionServices = CollectionServices();
  // GlobalKey _scaffoldKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
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
        elevation: 0,
         title: Consumer<CollectionProvider>(
          builder: (context, value, child) => 
            Text(
            '${value.collection.name}',
            style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: Consumer<ThemeChanger>(
        builder: (context, theme, child) => Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: _deviceServices.getDevices(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Device> devices = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          return ListDeviceCard(
                             icon: Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          Assets.deviceIcon,
                                          scale: 1.5,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                    ),
                            title: devices[index].name ?? 'No name',
                            onTap: () {
                              addSelectetdDevice(devices[index]);
                            },
                            // icon:,
                          );
                        },
                      );
                    } else
                      return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addSelectetdDevice(Device device) async {
    var collection = Provider.of<CollectionProvider>(context).collection;
    showLoading(context);
    var res = await _collectionServices.addDeviceToCollection(
        collection.id, device.id);
    if (res != null) {
      stopLoading();
      if (res) {
        collection.devices.add(device.id);
        var devices = await Provider.of<DeviceProvider>(context).devices;
        devices.add(device);
        Future<List<Device>> devs() async {
          var devs = devices;
          return devs;
        }
        Provider.of<DeviceProvider>(context).setDevices(devs());
        Provider.of<CollectionProvider>(context).setCollection(collection);
      } else {
        final snackBar = SnackBar(content: Text('Device already there!!'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      errorDialog(collection.name, device.name);
    }
  }

  stopLoading() {
    Navigator.pop(context);
  }


  errorDialog(String collectionName, String deviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            'Error',
          ),
        ),
        content: Text(
            'Oh no!🤦‍♂️ can\'t add $deviceName to $collectionName now,\ncheck your connection or try later'),
        contentTextStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
