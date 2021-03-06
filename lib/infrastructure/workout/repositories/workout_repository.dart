import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/core/entities/week_enum.dart';
import '../../../domain/workout/entities/workout_done.dart';
import '../../../domain/workout/entities/workout_failure.dart';
import '../../../domain/workout/repositories/i_workout_repository.dart';
import '../datasources/i_workout_datasource.dart';
import '../models/workout_done_model.dart';

class WorkoutRepository implements IWorkoutRepository {
  final IWorkoutDatasource datasource;

  WorkoutRepository({@required this.datasource}) : assert(datasource != null);

  @override
  Future<Either<WorkoutFailure, List<WorkoutDone>>> getWorkoutsDone(int exerciseId) async {
    try {
      final models = await datasource.getWorkoutsDone(exerciseId);

      return right(models.map(WorkoutDoneModel.toEntity).toList());
    } on Exception {
      return left(const WorkoutFailure.storageError());
    }
  }

  @override
  Future<Either<WorkoutFailure, Unit>> markDone(
      int exerciseId, int month, WeekEnum week, int repsDone) async {
    try {
      return right(await datasource.markDone(exerciseId, month, week, repsDone));
    } on Exception {
      return left(const WorkoutFailure.storageError());
    }
  }

  @override
  Future<Either<WorkoutFailure, Unit>> remove(int id) async {
    try {
      return right(await datasource.remove(id));
    } on Exception {
      return left(const WorkoutFailure.storageError());
    }
  }
}
