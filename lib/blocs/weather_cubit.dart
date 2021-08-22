import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/states/weather.state.dart';
import 'package:weatherapp/weather.repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(WeatherStateInitial());
  Future<void> getWeather(String city) async {
    try {
      emit(WeatherStateLoading());
      final weather = await _weatherRepository.getWeatherFromCity(city);
      emit(WeatherStateSuccess(weather: weather));
    } catch (e) {
      emit(WeatherStateFailure());
    }
  }

  Future<void> refreshWeather(String city) async {
    try {
      final weather = await _weatherRepository.getWeatherFromCity(city);
      emit(WeatherStateSuccess(weather: weather));
    } catch (e) {
      emit(WeatherStateFailure());
    }
  }
}
