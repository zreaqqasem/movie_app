import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/people_feature/date/people_service.dart';
import 'package:movie_app/features/people_feature/presentation/bloc/people_states.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final PeopleService _service = PeopleService();

  PeopleCubit(super.initialState);

  Future<void> getPeople(int pageNumber) async {
    try {
      emit(PeopleLoading());
      final response = await _service.getPeople(1);
      emit(PeopleSuccess(response ?? []));
    } catch (e) {
      emit(PeopleFailure(e.toString()));
    }
  }
}
