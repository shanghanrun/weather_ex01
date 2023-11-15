import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  final Uri url; //String 타입이 아니라 Uri 타입
  Network(this.url);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(url);
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
