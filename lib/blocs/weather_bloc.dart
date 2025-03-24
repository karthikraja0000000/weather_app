import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather =
        await weatherRepository.fetchCurrentWeather(event.latitude, event.longitude);
        final forecast =
        await weatherRepository.fetchForecast(event.latitude, event.longitude);
        emit(WeatherLoaded(weather: weather, forecast: forecast));
      } catch (e) {
        emit(WeatherError(message: e.toString()));
      }
    });
  }
}
