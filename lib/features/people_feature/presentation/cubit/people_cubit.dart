// People Cubit - Dependency Inversion Principle (DIP)
// Depends on use case abstraction, not implementation details
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/people_feature/domain/usecases/get_popular_people_usecase.dart';
import 'package:movie_app/features/people_feature/presentation/cubit/people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final GetPopularPeopleUseCase getPopularPeopleUseCase;

  PeopleCubit({required this.getPopularPeopleUseCase})
      : super(PeopleInitialState());

  Future<void> loadPeople({int page = 1}) async {
    emit(PeopleLoadingState());

    final result = await getPopularPeopleUseCase(page);

    result.fold(
      (failure) => emit(PeopleErrorState(message: failure.message)),
      (people) => emit(PeopleLoadedState(people: people)),
    );
  }
}
