import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:home_app/services/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';

class UploadServices{
  
///Upload Image To Storage To Storage
Future<String> uploadImage(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(Api.uploadUrl);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('photo', stream, length,
        filename: basename(imageFile.path),
        contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var data = jsonDecode(res);
      print('dadfcsscdscsda tav');
      print(data);
      return data['result']['secure_url'];
    } else {
      return null;
    }
  }

}