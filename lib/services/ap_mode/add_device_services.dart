import 'dart:convert';
import 'package:home_app/models/credentials.dart';
import 'package:home_app/services/api/pref_services.dart';
import 'package:http/http.dart' as http;

class APModeServices extends PrefServices {
  static const String host = "http://192.168.4.1";
  static const String root = host + "/";
// {"ssid":"","wpa2":"","email":"","password":""}
  Future<bool> sendData(String ssid, String wpa2) async {
  
    print('inside send data to esp8266');
    Credentials credentials = credentialsFromJson(await getCredentials());
    var body = {
      "email": credentials.email,
      "password": credentials.password,
      "ssid": ssid,
      "wpa2": wpa2
    };
    http.Response response = await http.post(root, body: json.encode(body));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["ok"] == "1" ? true : false;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }
}
