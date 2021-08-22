import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/blocs/setting.bloc.dart';
import 'package:weatherapp/blocs/theme.bloc.dart';
import 'package:weatherapp/states/setting.state.dart';
import 'package:weatherapp/states/theme.state.dart';
import 'package:weatherapp/weather.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;
  TemperatureWidget({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);
  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';
  BoxedIcon _mapWeatherConditionToIcon({WeatherCondition weatherCondition}) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return BoxedIcon(WeatherIcons.day_sunny);
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return BoxedIcon(WeatherIcons.snow);
        break;
      case WeatherCondition.heavyCloud:
        return BoxedIcon(WeatherIcons.cloud_up);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return BoxedIcon(WeatherIcons.rain);
        break;
      case WeatherCondition.thunderstorm:
        return BoxedIcon(WeatherIcons.thunderstorm);
        break;
      case WeatherCondition.unknown:
        return BoxedIcon(WeatherIcons.sunset);
        break;
    }
    return BoxedIcon(WeatherIcons.sunset);
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mapWeatherConditionToIcon(
                weatherCondition: weather.weatherCondition),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: BlocBuilder<SettingBloc, SettingState>(
                builder: (context, settingState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Min temp: ${_formattedTemperature(weather.minTemp, settingState.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: _themeState.textColor),
                      ),
                      Text(
                        'Temp: ${_formattedTemperature(weather.temp, settingState.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: _themeState.textColor),
                      ),
                      Text(
                        'Max temp: ${_formattedTemperature(weather.maxTemp, settingState.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: _themeState.textColor),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
