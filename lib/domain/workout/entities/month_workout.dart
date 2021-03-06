import 'package:flutter/foundation.dart';
import 'package:power_progress/domain/workout/entities/accumulation_workout.dart';
import 'package:power_progress/domain/workout/entities/deload_workout.dart';
import 'package:power_progress/domain/workout/entities/intensification_workout.dart';
import 'package:power_progress/domain/workout/entities/realization_workout.dart';

class MonthWorkout {
  final int month;
  final double oneRm;
  final AccumulationWorkout accumulationWorkout;
  final IntensificationWorkout intensificationWorkout;
  final RealizationWorkout realizationWorkout;
  final DeloadWorkout deloadWorkout;

  MonthWorkout({
    @required this.month,
    @required this.oneRm,
    @required this.accumulationWorkout,
    @required this.intensificationWorkout,
    @required this.realizationWorkout,
    @required this.deloadWorkout,
  });
}
