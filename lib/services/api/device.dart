import 'dart:async';
import 'dart:convert';
import 'package:home_app/models/device_model.dart';
import 'package:home_app/services/api/api.dart';
import 'package:home_app/services/api/pref_services.dart';
import 'package:http/http.dart' as http;

class DeviceServices extends PrefServices{
///index devices for current user
  Future<List<Device>> getDevices() async {
    print('inside collections');
    String token = await getToken();
    print(token);
    String url = Api.devicesUrl;
    http.Response response =
        await http.get(url, headers: createAuthorizationHeader(token));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Device> devices = List<Device>();
      data.forEach((element) {
        devices.add(Device.fromMap(element));
      });
      print(devices);
      return devices;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///get devices by ids
   Future<List<Device>> getDevicesByIds(List<String> ids) async {
    print(ids);
    String token = await getToken();
    Map<String, List<String>> body = {"devices": ids};
    String url = Api.devicesbyIdsUrl;
    http.Response response = await http.post(url,
        headers: createAuthorizationHeader(token), body: json.encode(body));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Device> devices = List<Device>();
      data.forEach((element) {
        devices.add(Device.fromMap(element));
      });
      return devices;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///Update Specific Device
  Future<bool> updateDevice(String deviceId,Device device) async {
    String url = Api.devicesUrl;
     String token = await getToken();
    http.Response response = await http.put(url + deviceId,
        headers: createAuthorizationHeader(token),
        body: deviceToJson(device));
    if (response.statusCode == 200) {
      // print(response.body);
      return true;
    } else {
      print('error${response.statusCode}');
      return false;
    }
  }

  ///delete device 
  Future deleteDevice()async{  

}



}
