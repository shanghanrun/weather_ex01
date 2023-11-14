import 'package:flutter/material.dart';
import 'package:weather_ex01/mylocation.dart';
import 'network.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  static const url = 'https://api.openweathermap.org/data/2.5/weather';
  var lat, lon;
  var data, weather, temp, humidity, wind;
  bool isLoading = true; // 데이터 로딩상태를 관리하기 위한 변수

  Future<void> getLocation() async {
    //버튼눌렀을 때 실행,화면갱신포함
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    setState(() {
      lat = myLocation.lat;
      lon = myLocation.lon;
    });
  }

  Future<void> fetchData() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    lat = myLocation.lat;
    lon = myLocation.lon;
    Network network = Network(url, lat, lon); //lat,lon 값 얻기 위해 먼저 getLocation()
    data = await network.getJsonData();

    weather = data['weather'][0]['main'];
    temp = (data['main']['temp'] - 32) / 1.8;
    humidity = data['main']['humidity'];
    wind = data['wind']['speed'];
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
                      getLocation();
                    },
                    child: const Text(
                      'Get my location',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      fetchData();
                    },
                    child: const Text(
                      'Weather Info',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
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
