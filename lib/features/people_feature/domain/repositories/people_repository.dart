// Repository Interface - Dependency Inversion Principle (DIP)
// High-level modules should not depend on low-level modules
// Both should depend on abstractions
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/people_feature/domain/entities/person_entity.dart';

abstract class PeopleRepository {
  Future<Either<Failure, List<PersonEntity>>> getPopularPeople(int page);
}
