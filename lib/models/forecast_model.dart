
class ForecastModel {
  final String date;
  final double minTemp;
  final double maxTemp;
  final double avgTemp;

  ForecastModel({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.avgTemp,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: json['dt_txt'].split(' ')[0],
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
      avgTemp: (json['main']['temp'] as num).toDouble(),
    );
  }
}














// class ForecastModel {
//   final List<ForecastDay> forecast;
//
//   ForecastModel({required this.forecast});
//
//   factory ForecastModel.fromJson(Map<String, dynamic> json) {
//     List<ForecastDay> dailyForecast = (json['list'] as List).map((item) {
//       return ForecastDay.fromJson(item);
//     }).toList();
//
//     return ForecastModel(forecast: dailyForecast);
//   }
// }
//
// class ForecastDay {
//   final String date;
//   final double temperature;
//   final String description;
//   final String icon;
//
//   ForecastDay({
//     required this.date,
//     required this.temperature,
//     required this.description,
//     required this.icon,
//   });
//
//   factory ForecastDay.fromJson(Map<String, dynamic> json) {
//     return ForecastDay(
//       date: json['dt_txt'],
//       temperature: json['main']['temp'].toDouble(),
//       description: json['weather'][0]['description'],
//       icon: json['weather'][0]['icon'],
//     );
//   }
// }
