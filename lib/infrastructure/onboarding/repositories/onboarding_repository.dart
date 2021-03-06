import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/onboarding/entities/onboarding_failure.dart';
import '../../../domain/onboarding/repositories/i_onboarding_repository.dart';
import '../datasources/i_onboarding_datasource.dart';

class OnboardingRepository implements IOnboardingRepository {
  final IOnboardingDatasource datasource;

  OnboardingRepository({@required this.datasource}) : assert(datasource != null);

  @override
  Future<Either<OnboardingFailure, Unit>> done() async {
    try {
      await datasource.done();
      return right(unit);
    } on Exception {
      return left(const OnboardingFailure.storageError());
    }
  }

  @override
  Future<Either<OnboardingFailure, bool>> get isDone async {
    try {
      return right(await datasource.isDone);
    } on Exception {
      return left(const OnboardingFailure.storageError());
    }
  }
}
