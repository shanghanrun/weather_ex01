import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic weatherData;
  const WeatherScreen({required this.weatherData, super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var weather, temp, humidity, wind, city;
  @override
  void initState() {
    super.initState();
    print('WeatherScreen으로 날씨정보 받아옴 : \n${widget.weatherData}'); // 부모의 값
    updateData(widget.weatherData);
  }

  void updateData(dynamic data) {
    weather = data['weather'][0]['main'];
    temp = data['main']['temp'];
    humidity = data['main']['humidity'];
    wind = data['wind']['speed'];
    city = data['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '도시이름: $city',
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('날씨: $weather', style: const TextStyle(fontSize: 30)),
            // Text(
            //   '온도: ${temp!.toStringAsFixed(0)} ℃',
            // ), //반올림 된다.
            Text('온도: ${temp!.round()} ℃', //반올림
                style: const TextStyle(fontSize: 30)),
            Text('습도: $humidity', style: const TextStyle(fontSize: 30)),
            Text('풍속: $wind', style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
