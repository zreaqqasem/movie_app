// Remote Data Source - Retrofit API Client
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_app/features/people_feature/data/models/people_response_model.dart';

part 'people_remote_data_source.g.dart';

@RestApi()
abstract class PeopleRemoteDataSource {
  factory PeopleRemoteDataSource(Dio dio, {String baseUrl}) = _PeopleRemoteDataSource;

  @GET('/3/person/popular')
  Future<PeopleResponseModel> getPopularPeople(@Query('page') int page);
}
