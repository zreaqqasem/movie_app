// Response Model with JSON Serialization
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/features/people_feature/data/models/person_model.dart';

part 'people_response_model.g.dart';

@JsonSerializable()
class PeopleResponseModel {
  final int page;
  final List<PersonModel> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  const PeopleResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PeopleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleResponseModelToJson(this);
}
