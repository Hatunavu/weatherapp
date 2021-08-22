import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather.dart';

const baseUrl = 'https://www.metaweather.com';
final locationUrl = (city) => '${baseUrl}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';

abstract class WeatherRepository {
  Future<Weather> getWeatherFromCity(String city);
}

class FakeWeatherRepository implements WeatherRepository {
  final http.Client httpClient;
  FakeWeatherRepository({@required this.httpClient})
      : assert(httpClient != null);
  Future<int> getLocationIdFromCity(String city) async {
    final response = await this.httpClient.get(Uri.parse(locationUrl(city)));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('Error getting location id of: ${city}');
    }
  }

  Future<Weather> fetchWeather(int locationId) async {
    final response =
        await this.httpClient.get(Uri.parse(weatherUrl(locationId)));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from locationId');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }
}
