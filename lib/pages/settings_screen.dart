import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/unit_bloc.dart';
import '../blocs/unit_event.dart';
import '../blocs/unit_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Temperature Unit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
            BlocBuilder<UnitBloc, UnitState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: Text(state.unit == TemperatureUnit.celsius ? "Celsius (°C)" : "Fahrenheit (°F)"),
                  value: state.unit == TemperatureUnit.fahrenheit,
                  onChanged: (value) {
                    BlocProvider.of<UnitBloc>(context).add(ToggleUnit());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
