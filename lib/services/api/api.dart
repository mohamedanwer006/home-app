/// api Endpoints
class Api {
  //Api engine  
  static const String baseUrl = 'https://api-engine-v1.herokuapp.com/';
  static const String uploadUrl = 'https://mylastapi.herokuapp.com/'+ 'upload/';
  static const String userUrl = baseUrl + 'api/v1/users/';
  static const String userUpdateUrl = baseUrl + 'api/v1/users/update/';
  static const String devicesUrl = baseUrl + 'api/v1/devices/';
  static const String devicesbyIdsUrl = baseUrl + 'api/v1/devices/ids/';
  static const String collectionUrl = baseUrl + 'api/v1/collections/';
  static const String deviceToCollectionUrl = baseUrl + 'api/v1/collections/add_device/';
  static const String authUrl = baseUrl + 'auth/local';

}
  Map<String, String> createAuthorizationHeader(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
      'Accept-Language': 'en_US'
    };
  }