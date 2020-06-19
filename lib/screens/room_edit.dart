import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/components/show_loading.dart';
import 'package:home_app/models/device_model.dart';
import 'package:home_app/screens/home_page.dart';
import 'package:home_app/components/list_device_card.dart';
import 'package:home_app/services/api/collection.dart';
import 'package:home_app/services/api/uploadfiles.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/services/provider/devices_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RoomEdit extends StatefulWidget {
  static const String route = '/roomEdit';
  @override
  _RoomEditState createState() => _RoomEditState();
}

class _RoomEditState extends State<RoomEdit> {
  String _name = '';
  File _image;
  UploadServices _uploadServices = UploadServices();
  CollectionServices _collectionServices = CollectionServices();
  GlobalKey key = GlobalKey();
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  List<Device> devices = List<Device>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CollectionProvider>(
          builder: (context, value, child) => 
            Text(
            'Edit ${value.collection.name}',
            style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<CollectionProvider>(context).setCollections(_collectionServices.getCollections()) ;
            },
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
            padding: const EdgeInsets.only(top: 12.0, bottom: 12),
            child: RectIconButton(
                height: 28,
                width: 28,
                onPressed: () {
                  _updateRoomDetails();
                },
                color: Colors.white,
                child: Icon(
                  Icons.done,
                  size: 18,
                )),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///Top Bar
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
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
                      'You can select room image , edit name or remove device',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 12)),
                ),

                ///Room Image And Name
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        minWidth: 75,
                        height: 100,
                        onPressed: _selectImage,
                        elevation: 0,
                        color: Theme.of(context).backgroundColor,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: 75.0,
                          height: 100.0,
                          child: Center(
                            child: Text(
                              'Select\nimage🖼 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: _image == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  top:
                                      BorderSide(width: 1, color: Colors.white),
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ))),
                          height: 40,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                fontSize: 18,
                                // color: AppColors.accentColor_dark,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  hintText: ' Enter room name ...',
                                  hintStyle:
                                      Theme.of(context).textTheme.subtitle1,
                                  border: InputBorder.none),
                              onChanged: (val) {
                                setState(() {
                                  _name = val;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                ///Temp And Humidity Sensor
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                              ? AppColors.iconsColorBackground3_dark
                              : AppColors.iconsColorBackground2_light,
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: null,
                        ),
                      ),
                      Text('Select temp and humidity sensor'),
                    ],
                  ),
                )
              ],
            ),
          ),

          ///List Room's Devices
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
                      endIndent: 10,
                      indent: 10,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        future: Provider.of<DeviceProvider>(context).devices,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            devices = snapshot.data;
                            return ListView.builder(
                              // shrinkWrap: false,
                              scrollDirection: Axis.vertical,
                              itemCount: devices.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 1),
                                  child: ListDeviceCard(
                                    trailing: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
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
                                    onTap: () async {
                                      print('${devices[index].id}');
                                      bool res = await removeDevice(
                                          Provider.of<CollectionProvider>(
                                                  context)
                                              .collection
                                              .id,
                                          devices[index].id);
                                      if (res) {
                                        devices.removeAt(index);
                                        Future<List<Device>> devs() async {
                                          var devs = devices;
                                          return devs;
                                        }
                                        Provider.of<DeviceProvider>(context)
                                            .setDevices(devs());
                                         ///Todo:update Collection devices ids   
                                        Provider.of<CollectionProvider>(context)
                                            .collection
                                            .devices
                                            .remove((item)=>item.id ==devices[index].id);
                                          
                                      }
                                    },
                                  )),
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
          )
        ],
      ),
    );
  }

  void _selectImage() {
    getImage();
  }

  void _updateRoomDetails() async {
    var collection = Provider.of<CollectionProvider>(context).collection;
    if (_image != null && _name.length > 0) {
      showLoading(context);
      String _picUrl = await _uploadServices.uploadImage(_image);
      Map data = {
        "picture": _picUrl,
        "name": _name,
      };
      if (await _collectionServices.updateCollection(collection.id, data) !=
          null) {
        Provider.of<CollectionProvider>(context)
            .setCollections(_collectionServices.getCollections());
        stopLoading();
        print('complet update device info');
      } else {
        stopLoading();
        print('error');
      }
    } else if (_image != null && _name.length == 0) {
      showLoading(context);
      String _picUrl = await _uploadServices.uploadImage(_image);
      Map data = {
        "picture": _picUrl,
      };
      if (await _collectionServices.updateCollection(collection.id, data) !=
          null) {
        Provider.of<CollectionProvider>(context)
            .setCollections(_collectionServices.getCollections());
        stopLoading();
        print('complet update device info');
      } else {
        stopLoading();
        print('error');
      }
    } else if (_image == null && _name.length > 0) {
      showLoading(context);
      Map data = {
        "name": _name,
      };
      if (await _collectionServices.updateCollection(collection.id, data) !=
          null) {
        Provider.of<CollectionProvider>(context)
            .setCollections(_collectionServices.getCollections());
        stopLoading();
        print('complet update device info');
      } else {
        stopLoading();
        print('error');
      }
    } else if (_image == null && _name.length == 0) {
      //Nothing
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text(
                'no changes to update 🙄',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      );
    } else {}
  }

  stopLoading() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, HomePage.route);
  }
  Future<bool> removeDevice(collectionId, deviceId) async {
    return await _collectionServices.removeDeviceFromCollection(
        collectionId, deviceId);
  }
}

