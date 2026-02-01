// BLoC States - Single Responsibility Principle (SRP)
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/people_feature/domain/entities/person_entity.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object?> get props => [];
}

class PeopleInitialState extends PeopleState {}

class PeopleLoadingState extends PeopleState {}

class PeopleLoadedState extends PeopleState {
  final List<PersonEntity> people;

  const PeopleLoadedState({required this.people});

  @override
  List<Object?> get props => [people];
}

class PeopleErrorState extends PeopleState {
  final String message;

  const PeopleErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
