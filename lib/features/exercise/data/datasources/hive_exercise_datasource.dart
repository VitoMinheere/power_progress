import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../core/util/util_functions.dart';
import '../models/exercise_model.dart';
import 'i_exercise_datasource.dart';

class HiveExerciseDatasource implements IExerciseDatasource {
  final Box<ExerciseModel> localStorage;

  HiveExerciseDatasource({@required this.localStorage}) : assert(localStorage != null);

  @override
  Future<Unit> add(ExerciseModel exercise) async {
    // insert and retrieve auto-increment id
    final int insertedId = await tryOrCrash(
      () => localStorage.add(exercise),
      (_) => throw Exception(),
    );

    // add generated id to the exercise
    exercise.id = insertedId;

    // update exercise with generated id
    await tryOrCrash(
      () => localStorage.put(insertedId, exercise),
      (_) => throw Exception(),
    );

    return unit;
  }

  @override
  Future<List<ExerciseModel>> get() async {
    final exercises = tryOrCrash(
      () => localStorage.values.toList(),
      (_) => throw Exception(),
    );

    return exercises;
  }
}
