import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late var lat, lon;
  late var weather, temp, humidity, wind;
  bool isLoading = true; // 데이터 로딩상태를 관리하기 위한 변수
  Future<Position?> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
      return position;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> fetchData() async {
    Position? position = await getLocation(); // 완료될 때까지 기다린다.
    if (position != null) {
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
      });
    } else {
      return;
    }

    await dotenv.load();
    String apiKey = dotenv.env['APIKEY']!;
    // const apiKey = '3b37f6cba7de33d06a1f3edc2f2fa085';
    // var lat = 36.6248;  // var lon = 126.978;
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // HTTP 요청이 성공한 경우
      var weatherData = jsonDecode(response.body);
      print(weatherData);
      setState(() {
        weather = weatherData['weather'][0]['main'];
        temp = (weatherData['main']['temp'] - 32) / 1.8;
        humidity = weatherData['main']['humidity'];
        wind = weatherData['wind']['speed'];
        isLoading = false; // 데이터 로딩이 완료됨을 표시
      });
    } else {
      // HTTP 요청이 실패한 경우
      print('Failed to load weather data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    // getLocation();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getLocation();
                    },
                    child: const Text(
                      'Get my location',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                      '위치: ${lat.toStringAsFixed(2)},  ${lon.toStringAsFixed(2)}'),
                  Text('날씨: $weather'),
                  Text('온도: ${temp.toStringAsFixed(2)}'),
                  Text('습도: $humidity'),
                  Text('풍속: $wind'),
                ],
              ),
      ),
    );
  }
}
