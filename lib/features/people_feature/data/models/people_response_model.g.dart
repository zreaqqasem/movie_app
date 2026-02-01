// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleResponseModel _$PeopleResponseModelFromJson(Map<String, dynamic> json) =>
    PeopleResponseModel(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => PersonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$PeopleResponseModelToJson(
  PeopleResponseModel instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
