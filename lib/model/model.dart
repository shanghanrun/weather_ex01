import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model {
  Widget? getWeatherIcon(int id) {
    if (id < 300) {
      return SvgPicture.asset(
        'svg/climacon-cloud_lightning.svg',
      );
    } else if (id < 600) {
      return SvgPicture.asset(
        'svg/climacon-cloud_snow_alt.svg',
      );
    } else if (id == 800) {
      return SvgPicture.asset(
        'svg/climacon-sun.svg',
      );
    } else if (id <= 804) {
      return SvgPicture.asset(
        'svg/climacon-cloud_sun.svg',
      );
    }
    return null;
  }
}
