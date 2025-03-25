import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherRepository {
  final String apiKey = "f2c0d0d477b427861c8f304346f2934a";

  Future<WeatherModel> fetchCurrentWeather(double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  // Future<ForecastModel> fetchForecast(double lat, double lon) async {
  //   final url =
  //       "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
  //
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     return ForecastModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception("Failed to load forecast data");
  //   }
  // }




  Future<List<ForecastModel>> fetchForecast(double lat, double lon,) async {
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return processForecastData(data);
    } else {
      throw Exception("Failed to load forecast data");
    }
  }

  Future<List<ForecastModel>> processForecastData(Map<String, dynamic> data) async {
    final List<dynamic> foreCastList = data["list"];
    Map<String, List<double>> dailyTemps = {};

    for (var item in foreCastList) {
      String date = item['dt_txt'].split(' ')[0];
      double temp = (item['main']['temp'] as num).toDouble();

      if (!dailyTemps.containsKey(date)) {
        dailyTemps[date] = [];
      }
      dailyTemps[date]!.add(temp);
    }

    List<ForecastModel> dailyForecast = dailyTemps.entries.map((entry) {
      String date = entry.key;
      List<double> temps = entry.value.cast<double>();

      double minTemp = temps.reduce((a, b) => a < b ? a : b);
      double maxTemp = temps.reduce((a, b) => a > b ? a : b);
      double avgTemp = temps.reduce((a, b) => a + b) / temps.length;

      return ForecastModel(
        date: date,
        minTemp: minTemp,
        maxTemp: maxTemp,
        avgTemp: avgTemp,
      );
    }).toList();

    return Future.value(dailyForecast);
  }
}