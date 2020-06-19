import 'package:http/http.dart' as http;
import 'package:home_app/models/weather.dart';

class WeatherServices {

  String url = 'https://api.climacell.co/v3/weather/realtime?lat=31.0409&lon=31.3785&unit_system=si&fields=temp%2Chumidity&apikey=fuQlUwQnq8OVm42WdLv3vuRT88Qb8j6Z';

  Future<Weather> fetchData() async {
    print('in weather');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

}
