
import 'package:movie_app/features/people_feature/date/models/popular_response_model.dart';

abstract class PeopleState{}

class PeopleInitialState extends PeopleState{}

class PeopleLoading extends PeopleState{}

class PeopleSuccess extends PeopleState{
  final List<Result> response;
  PeopleSuccess(this.response);
}

class PeopleFailure extends PeopleState{
  final String errorMessage;
  PeopleFailure(this.errorMessage);
}