import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/setting.bloc.dart';
import 'package:weatherapp/blocs/theme.bloc.dart';
import 'package:weatherapp/blocs/weather.bloc.dart';
import 'package:weatherapp/blocs/weather.bloc.observer.dart';
import 'package:weatherapp/blocs/weather_cubit.dart';
import 'package:weatherapp/screens/weather.screen.dart';
import 'package:weatherapp/states/theme.state.dart';
import 'package:weatherapp/weather.repository.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = WeatherBlocObserver();
  final FakeWeatherRepository weatherRepository =
      FakeWeatherRepository(httpClient: http.Client());

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      BlocProvider<SettingBloc>(create: (context) => SettingBloc())
    ],
    child: MyApp(
      weatherRepository: weatherRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        home: BlocProvider(
          create: (context) =>
              WeatherCubit(FakeWeatherRepository(httpClient: http.Client())),
          child: WeatherScreen(),
        ),
      );
    });
  }
}
