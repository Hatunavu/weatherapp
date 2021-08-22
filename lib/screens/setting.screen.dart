import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/setting.bloc.dart';
import 'package:weatherapp/events/setting.event.dart';
import 'package:weatherapp/states/setting.state.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingBloc, SettingState>(
              builder: (context, settingState) {
            return ListTile(
              title: Text('Temperature Unit'),
              isThreeLine: true,
              subtitle: Text(
                  settingState.temperatureUnit == TemperatureUnit.celsius
                      ? 'Celsius'
                      : 'Fahrenheit'),
              trailing: Switch(
                value: settingState.temperatureUnit == TemperatureUnit.celsius,
                onChanged: (_) => BlocProvider.of<SettingBloc>(context)
                    .add(SettingEventToggleUnit()),
              ),
            );
          })
        ],
      ),
    );
  }
}
