import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_ui/pages/weather_screen.dart';
import 'package:weather_ui/repositories/weather_repository.dart';
// import 'bloc/weather_bloc.dart';
// import 'bloc/unit_bloc.dart';
import 'blocs/unit_bloc.dart';
import 'blocs/weather_bloc.dart';
// import 'repository/weather_repository.dart';
// import 'screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc(weatherRepository: WeatherRepository())),
        BlocProvider(create: (context) => UnitBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800), // Base size (change as per design)
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Weather App",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: WeatherScreen(),
          );
        },
      ),
    );
  }
}
