import 'dart:convert';
import 'package:home_app/models/user.dart';
import 'package:home_app/services/api/api.dart';
import 'package:home_app/services/api/pref_services.dart';
import 'package:http/http.dart' as http;

class UserServices extends PrefServices{
  /// update user data 
 Future<User> updateUser(String id, Map data) async {
    print('inside updateUser');
    String token = await getToken();
    String url = Api.userUpdateUrl;
    print("user id: $id ");
    http.Response response = await http.put(url + '$id',
        headers: createAuthorizationHeader(token), body: jsonEncode(data));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print("res*************************\n"+data.toString());
      saveUserData(json.encode(data));
      User user = User.fromMap(data);
      return user;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }
  
}
