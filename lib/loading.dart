import 'package:flutter/material.dart';
import 'package:weather_ex01/mylocation.dart';
import 'network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/weather_screen.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  var _lat, _lon;
  var _data; // json 결과 다양한 타입
  // String? weather;
  // double? temp, humidity, wind;
  // bool isLoading = true; // 데이터 로딩상태를 관리하기 위한 변수

  // Future<void> getLocation() async {
  //   //버튼눌렀을 때 실행,화면갱신포함
  //   MyLocation myLocation = MyLocation();
  //   await myLocation.getCurrentLocation();
  //   setState(() {
  //     _lat = myLocation.lat;
  //     _lon = myLocation.lon;
  //   });
  // }

  Future<void> fetchData() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    _lat = myLocation.lat;
    _lon = myLocation.lon;

    await dotenv.load();
    String apiKey = dotenv.env['APIKEY']!;
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$_lat&lon=$_lon&appid=$apiKey&units=metric');

    Network network = Network(url);
    _data = await network.getJsonData();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(weatherData: _data)));

    // weather = _data['weather'][0]['main'];
    // temp = (_data['main']['temp'] - 32) / 1.8;
    // humidity = _data['main']['humidity'];
    // wind = _data['wind']['speed'];
    // setState(() {
    //   isLoading = false; //데이터 로딩완료
    // });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center());
  }
  //       child: isLoading
  //           ? const CircularProgressIndicator()
  //           : Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     getLocation();
  //                   },
  //                   child: const Text(
  //                     'Get my location',
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 30),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     fetchData();
  //                   },
  //                   child: const Text(
  //                     'Weather Info',
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 30),
  //                 Text(
  //                     '위치: ${_lat.toStringAsFixed(2)},  ${_lon.toStringAsFixed(2)}'),
  //                 Text('날씨: $weather'),
  //                 Text('온도: ${temp!.toStringAsFixed(2)}'),
  //                 Text('습도: $humidity'),
  //                 Text('풍속: $wind'),
  //               ],
  //             ),
  //     ),
  //   );
  // }
}
