// Use Case - Single Responsibility Principle (SRP)
// Each use case has one specific business logic responsibility
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/people_feature/domain/entities/person_entity.dart';
import 'package:movie_app/features/people_feature/domain/repositories/people_repository.dart';

// Base use case interface - Interface Segregation Principle (ISP)
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Specific use case for getting popular people
class GetPopularPeopleUseCase implements UseCase<List<PersonEntity>, int> {
  final PeopleRepository repository;

  const GetPopularPeopleUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PersonEntity>>> call(int page) async {
    // Business logic validation
    if (page < 1) {
      return const Left(ValidationFailure('Page number must be greater than 0'));
    }

    return await repository.getPopularPeople(page);
  }
}
