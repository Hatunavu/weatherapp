import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/events/theme.event.dart';
import 'package:weatherapp/states/theme.state.dart';
import 'package:weatherapp/weather.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white));
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    // TODO: implement mapEventToState
    ThemeState newThemState;
    if (themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherCondition;
      if (weatherCondition == WeatherCondition.clear ||
          weatherCondition == WeatherCondition.lightCloud) {
        newThemState =
            ThemeState(backgroundColor: Colors.yellow, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.hail ||
          weatherCondition == WeatherCondition.snow ||
          weatherCondition == WeatherCondition.sleet) {
        newThemState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.heavyCloud) {
        newThemState =
            ThemeState(backgroundColor: Colors.grey, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.heavyRain ||
          weatherCondition == WeatherCondition.lightRain ||
          weatherCondition == WeatherCondition.showers) {
        newThemState =
            ThemeState(backgroundColor: Colors.indigo, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.thunderstorm) {
        newThemState = ThemeState(
            backgroundColor: Colors.deepPurple, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.unknown) {
        newThemState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }
      yield newThemState;
    }
  }
}
