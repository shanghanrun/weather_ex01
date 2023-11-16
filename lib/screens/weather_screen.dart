import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

import '../model/model.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic weatherData;
  final dynamic airData;
  const WeatherScreen(
      {required this.weatherData, required this.airData, super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var weather,
      id,
      icon,
      temp,
      humidity,
      wind,
      city,
      description,
      index,
      dust1,
      dust2,
      airIcon,
      airState;
  var date = DateTime.now();
  @override
  void initState() {
    super.initState();
    print('WeatherScreen으로 날씨정보 받아옴 : \n${widget.weatherData}'); // 부모의 값
    print('WeatherScreen으로 대기정보 받아옴 : \n${widget.airData}');
    updateData(widget.weatherData, widget.airData);
  }

  void updateData(dynamic data1, dynamic data2) {
    weather = data1['weather'][0]['main'];
    id = data1['weather'][0]['id'];
    description = data1['weather'][0]['description'];
    temp = data1['main']['temp'];
    temp = temp.round();
    humidity = data1['main']['humidity'];
    wind = data1['wind']['speed'];
    city = data1['name'];

    index = data2['list'][0]['main']['aqi'];
    dust1 = data2['list'][0]['components']['pm10'];
    dust2 = data2['list'][0]['components']['pm2_5'];

    Model model = Model();
    icon = model.getWeatherIcon(id);
    airIcon = model.getAirIcon(index);
    airState = model.getAirState(index);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // title: const Text(''),
          leading: IconButton(
            icon: const Icon(Icons.near_me),
            onPressed: () {},
            iconSize: 30,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.location_searching),
              onPressed: () {},
              iconSize: 30,
            ),
          ]),
      body: Container(
        // padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Image.asset('images/background.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 150),
                            Text(
                              '$city',
                              style: GoogleFonts.lato(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                  const Duration(minutes: 1),
                                  builder: (context) {
                                    print(getSystemTime());
                                    return Text(
                                      getSystemTime(),
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                                // const SizedBox(width: 10),
                                Text(
                                  DateFormat('- EEE, ').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(icon),
                                const SizedBox(width: 10),
                                Text(
                                  description,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Divider(
                        height: 15,
                        thickness: 2,
                        color: Colors.white54,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                airIcon,
                                width: 37,
                                height: 35,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                airState,
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                dust1.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'µg/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$dust2',
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'µg/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
