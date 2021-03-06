import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../core/usecases/usecase.dart';
import '../../core/entities/week_enum.dart';
import '../../exercise/usecases/update_exercise_next_month.dart';
import '../../exercise/usecases/update_exercise_next_week.dart';
import '../entities/workout_failure.dart';
import '../repositories/i_workout_repository.dart';

class MarkWorkoutUndone implements UseCase<Unit, WorkoutFailure, MarkWorkoutUndoneParams> {
  final IWorkoutRepository repository;
  final UpdateExerciseNextWeek updateExerciseNextWeek;
  final UpdateExerciseNextMonth updateExerciseNextMonth;

  MarkWorkoutUndone({
    @required this.repository,
    @required this.updateExerciseNextWeek,
    @required this.updateExerciseNextMonth,
  })  : assert(repository != null),
        assert(updateExerciseNextWeek != null),
        assert(updateExerciseNextMonth != null);

  @override
  Future<Either<WorkoutFailure, Unit>> call(MarkWorkoutUndoneParams params) async {
    final result = await repository.remove(params.id);

    await updateExerciseNextWeek(
      UpdateExerciseNextWeekParams(
        exerciseId: params.exerciseId,
        nextWeek: params.week.previous(),
      ),
    );

    if (params.week == WeekEnum.deload) {
      await updateExerciseNextMonth(
        UpdateExerciseNextMonthParams(
          exerciseId: params.exerciseId,
          nextMonth: params.month - 1,
        ),
      );
    }

    return result;
  }
}

class MarkWorkoutUndoneParams extends Equatable {
  final int id;
  final int exerciseId;
  final WeekEnum week;
  final int month;

  const MarkWorkoutUndoneParams({
    @required this.id,
    @required this.exerciseId,
    @required this.week,
    @required this.month,
  });

  @override
  List<Object> get props => [
        id,
        exerciseId,
        week,
        month,
      ];
}
