import 'package:flutter/material.dart';
import 'package:weather_ex01/mylocation.dart';
import 'network.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late var lat, lon;
  late var weather, temp, humidity, wind;
  bool isLoading = true; // 데이터 로딩상태를 관리하기 위한 변수

  // Future<void> getLocation() async {
  //   MyLocation myLocation = MyLocation();
  //   await myLocation.getLocation();
  //   lat = myLocation.lat;
  //   lon = myLocation.lon;
  // }

  Future<void> fetchData() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getLocation();
    lat = myLocation.lat;
    lon = myLocation.lon;
    Network network = Network(lat, lon); //lat,lon 값 얻기 위해 먼저 getLocation()
    await network.fetchData();

    weather = network.weather;
    temp = network.temp;
    humidity = network.humidity;
    wind = network.wind;
    setState(() {
      isLoading = false; //데이터 로딩완료
    });
  }

  @override
  void initState() {
    super.initState();
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
                      // getLocation();
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
