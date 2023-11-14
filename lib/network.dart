import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Network {
  late String? weather;
  late double? temp, humidity, wind;
  late double lat, lon;
  Network(this.lat, this.lon);

  Future<void> fetchData() async {
    await dotenv.load();
    String apiKey = dotenv.env['APIKEY']!;
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // HTTP 요청이 성공한 경우
      var weatherData = jsonDecode(response.body);
      print(weatherData);

      weather = weatherData['weather'][0]['main'];
      temp = (weatherData['main']['temp'] - 32) / 1.8;
      humidity = weatherData['main']['humidity'];
      wind = weatherData['wind']['speed'];
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
    }
  }
}
