import 'package:flutter_bloc/flutter_bloc.dart';
import 'unit_event.dart';
import 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitState(unit: TemperatureUnit.celsius)) {
    on<ToggleUnit>((event, emit) {
      final newUnit = state.unit == TemperatureUnit.celsius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celsius;
      emit(UnitState(unit: newUnit));
    });
  }
}
