import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:weather_app/models/current_response_model.dart';
import 'package:weather_app/models/fourecast_response_model.dart';
import 'package:weather_app/utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentResponseModel? currentResponseModel;
  FourecastResponseModel? fourecastResponseModel;
  double latitude = 0.0, longitude = 0.0;
  String unit = 'metric';

  bool get hasDataLoaded =>
      currentResponseModel != null && fourecastResponseModel != null;

  void setNewLocation(double lat, double lng) {
    latitude = lat;
    longitude = lng;
  }

  getWeatherData() {
    _getCurrentData();
    _getForecastData();
  }

  void _getCurrentData() async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$unit&appid=$weather_api_key');
    try {
      final response = await get(uri);
      final map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        currentResponseModel = CurrentResponseModel.fromJson(map);
        print(currentResponseModel!.main!.temp!.round());
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  void _getForecastData() async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=$unit&appid=$weather_api_key');
    try {
      final response = await get(uri);
      final map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        fourecastResponseModel = FourecastResponseModel.fromJson(map);
        print(fourecastResponseModel!.list!.length);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
