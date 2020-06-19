import 'dart:async';
import 'dart:convert';
import 'package:home_app/models/collections.dart';
import 'package:home_app/services/api/api.dart';
import 'package:home_app/services/api/pref_services.dart';
import 'package:http/http.dart' as http;

class CollectionServices extends PrefServices {
  // AuthServices _authServices=AuthServices();
  //  CollectionServices._();

  ///Get collections For current user
  Future<List<Collection>> getCollections() async {
    print('inside getcollections');
    String token = await getToken();
    String url = Api.collectionUrl;
    http.Response response =
        await http.get(url, headers: createAuthorizationHeader(token));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Collection> collections = List<Collection>();
      data.forEach((element) {
        collections.add(Collection.fromMap(element));
      });
      // print(collections);
      return collections;
    }
    // else if(response.statusCode==401){
    //   //Todo:refresh session
    // }
     else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///create new collection in db
  Future<Collection> createCollection(Collection collection) async {
    print('inside createcollection');
    String token = await getToken();
    String url = Api.collectionUrl;
    http.Response response = await http.post(url,
        headers: createAuthorizationHeader(token),
        body: collectionToJson(collection.copyWith(devices: [])));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Collection collection = Collection.fromMap(data);
      return collection;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///update specific collection
  Future<Collection> updateCollection(String id, Map data) async {
    print('inside updatecollection');
    String token = await getToken();
    String url = Api.collectionUrl;
    print("collection id: $id ");
    http.Response response = await http.put(url + '$id',
        headers: createAuthorizationHeader(token), body: jsonEncode(data));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Collection collection = Collection.fromMap(data);
      return collection;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///delete specific collection
  Future<bool> deleteCollection(String id) async {
    print('inside deletecollection');
    String token = await getToken();
    String url = Api.collectionUrl;
    http.Response response = await http.delete(
      url + '$id',
      headers: createAuthorizationHeader(token),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///add device to specific collection
  Future<bool> addDeviceToCollection(String collectionId, String deviceId) async {
    print('inside addDeviceToCollection');
    String token = await getToken();
    String url = Api.deviceToCollectionUrl;
    print("collection id: $collectionId ");
    print("collection id: $deviceId ");
    var body = {
      "_id":deviceId
    };
    http.Response response = await http.put(url + '$collectionId',
        headers: createAuthorizationHeader(token), body: jsonEncode(body));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('test addDeviceToCollection data ok : ' + data["nModified"].toString());
      return  data["nModified"]==1? true : false;
    } else {
      print('error${response.statusCode}');
      return null;
    }
  }

  ///remove device from specific collection
  Future<bool> removeDeviceFromCollection(String collectionId, String deviceId) async {
     print('inside remove device');
    String token = await getToken();
    String url = Api.collectionUrl;
    print("collection id: $collectionId ");
    http.Response response = await http.delete(url + '$collectionId/$deviceId',
        headers: createAuthorizationHeader(token));
    if (response.statusCode == 204) {
      print('object true');
      return true ;
    } else {
      print('error${response.statusCode}');
      return false;
    }
  }
}
