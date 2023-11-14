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
  var lat, lon;
  Future<Position?> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
      // lat = position.latitude;
      // lon = position.longitude;
      print(position.latitude);
      print(position.longitude);
      return position;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> fetchData() async {
    Position? position = await getLocation(); // 완료될 때까지 기다린다.
    if (position != null) {
      lat = position.latitude;
      lon = position.longitude;
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
        child: ElevatedButton(
          onPressed: () {
            getLocation();
          },
          child: const Text(
            'Get my location',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
