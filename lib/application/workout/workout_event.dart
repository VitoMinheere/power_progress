part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class WorkoutGenerateEvent extends WorkoutEvent {
  final int month;
  final double oneRm;
  final double incrementation;

  const WorkoutGenerateEvent({
    @required this.month,
    @required this.oneRm,
    @required this.incrementation,
  });

  @override
  List<Object> get props => [month, oneRm, incrementation];
}
