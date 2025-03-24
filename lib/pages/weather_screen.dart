import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../blocs/unit_bloc.dart';
import '../blocs/unit_state.dart';
import '../blocs/weather_bloc.dart';
import '../blocs/weather_event.dart';
import '../blocs/weather_state.dart';
import '../services/services_location.dart';
import 'settings_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  final LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    try {
      final position = await locationService.getCurrentLocation();
      BlocProvider.of<WeatherBloc>(context).add(
        FetchWeather(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentHour = DateTime.now().hour;
    Color backgroundColor =
        (currentHour >= 6 && currentHour < 18)
            ? Colors.yellow[200]!
            : Colors.blue[900]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return CircularProgressIndicator();
            } else if (state is WeatherLoaded) {
              return BlocBuilder<UnitBloc, UnitState>(
                builder: (context, unitState) {
                  bool isFahrenheit =
                      unitState.unit == TemperatureUnit.fahrenheit;

                  double convertTemperature(double temp) {
                    return isFahrenheit ? (temp * 9 / 5) + 32 : temp;
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "City: ${state.weather.city}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Temp: ${convertTemperature(state.weather.temperature).toStringAsFixed(1)}°${isFahrenheit ? 'F' : 'C'}",
                            ),
                            Text("Condition: ${state.weather.description}"),
                            SizedBox(height: 20.h),
                            Text(
                              "5-Day Forecast",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.forecast.forecast.length,
                          itemBuilder: (context, index) {
                            final day = state.forecast.forecast[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  "https://openweathermap.org/img/w/${day.icon}.png",
                                ),
                                title: Text(day.date,style: TextStyle(fontSize: 12.r),),
                                subtitle: Text(
                                  "${convertTemperature(day.temperature).toStringAsFixed(1)}°${isFahrenheit ? 'F' : 'C'} - ${day.description}",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (state is WeatherError) {
              return Text("Error: ${state.message}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
