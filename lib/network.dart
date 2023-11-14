import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Network {
  final String url;
  final double lat, lon;
  Network(this.url, this.lat, this.lon);

  Future<dynamic> getJsonData() async {
    await dotenv.load();
    String apiKey = dotenv.env['APIKEY']!;
    var url2 = Uri.parse('$url?lat=$lat&lon=$lon&appid=$apiKey');

    http.Response response = await http.get(url2);
    if (response.statusCode == 200) {
      // HTTP 요청이 성공한 경우
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      return null;
    }
  }
}
