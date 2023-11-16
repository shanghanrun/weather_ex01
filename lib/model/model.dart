class Model {
  String getWeatherIcon(int id) {
    if (id < 300) {
      return 'svg/climacon-cloud_lightning.svg';
    } else if (id < 600) {
      return 'svg/climacon-cloud_snow_alt.svg';
    } else if (id == 800) {
      return 'svg/climacon-sun.svg';
    } else if (id <= 804) {
      return 'svg/climacon-cloud_sun.svg';
    }
    return 'svg/climacon-sun_fill.svg';
  }

  String getAirIcon(int index) {
    if (index == 1) {
      return 'images/good.png';
    } else if (index == 2) {
      return 'images/fair.png';
    } else if (index == 3) {
      return 'images/moderate.png';
    } else if (index == 4) {
      return 'images/poor.png';
    } else if (index == 5) {
      return 'images/bad.png';
    }
    return 'images/fair.png';
  }

  String getAirState(int index) {
    if (index == 1) {
      return '매우좋음';
    } else if (index == 2) {
      return '좋음';
    } else if (index == 3) {
      return '보통';
    } else if (index == 4) {
      return '나쁨';
    } else if (index == 5) {
      return '매우나쁨';
    }
    return '보통';
  }
}
