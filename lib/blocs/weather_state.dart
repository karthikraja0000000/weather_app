import '../models/weather_model.dart';
import '../models/forecast_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final List<ForecastModel> forecast;

  WeatherLoaded({required this.weather, required this.forecast});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
