import 'package:dartz/dartz.dart';

import '../../core/entities/week_enum.dart';
import '../entities/exercise.dart';
import '../entities/exercise_failure.dart';

abstract class IExerciseRepository {
  Future<Either<ExerciseFailure, Unit>> add(Exercise exercise);
  Future<Either<ExerciseFailure, List<Exercise>>> get();
  Future<Either<ExerciseFailure, Unit>> remove(List<int> ids);
  Future<Either<ExerciseFailure, Unit>> updateNextWeek(int exerciseId, WeekEnum week);
  Future<Either<ExerciseFailure, Unit>> updateNextMonth(int exerciseId, int nextMonth);
}
