import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/theme.bloc.dart';
import 'package:weatherapp/blocs/weather.bloc.dart';
import 'package:weatherapp/blocs/weather_cubit.dart';
import 'package:weatherapp/events/theme.event.dart';
import 'package:weatherapp/events/weather.event.dart';
import 'package:weatherapp/screens/city.search.screen.dart';
import 'package:weatherapp/screens/setting.screen.dart';
import 'package:weatherapp/screens/temperature.widget.dart';
import 'package:weatherapp/states/theme.state.dart';
import 'package:weatherapp/states/weather.state.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer<void> _completer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather app'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final typedCity = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchScreen()));
                if (typedCity != null) {
                  BlocProvider.of<WeatherCubit>(context).getWeather(typedCity);
                }
              })
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                  weatherCondition: weatherState.weather.weatherCondition));
              _completer?.complete();
              _completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                return RefreshIndicator(
                    child: Container(
                      color: themeState.backgroundColor,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Text(
                                weather.location,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeState.textColor),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2)),
                              Center(
                                child: Text(
                                  'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: themeState.textColor),
                                ),
                              ),
                              TemperatureWidget(weather: weather)
                            ],
                          ),
                          TemperatureWidget(weather: weather)
                        ],
                      ),
                    ),
                    onRefresh: () {
                      BlocProvider.of<WeatherCubit>(context)
                          .refreshWeather(weather.location);
                      return _completer.future;
                    });
              });
            }
            if (weatherState is WeatherStateFailure) {
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.red, fontSize: 16),
              );
            }
            return Center(
              child: Text(
                'Select a location',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
