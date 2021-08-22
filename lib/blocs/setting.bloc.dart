import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/events/setting.event.dart';
import 'package:weatherapp/states/setting.state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState(temperatureUnit: TemperatureUnit.celsius));
  @override
  Stream<SettingState> mapEventToState(SettingEvent settingEvent) async* {
    // TODO: implement mapEventToState
    if (settingEvent is SettingEventToggleUnit) {
      final newSettingState = SettingState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius);
      yield newSettingState;
    }
  }
}
