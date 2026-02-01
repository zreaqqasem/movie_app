// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  profilePath: json['profile_path'] as String?,
  popularity: (json['popularity'] as num).toDouble(),
  knownForDepartment: json['known_for_department'] as String,
  gender: (json['gender'] as num).toInt(),
  adult: json['adult'] as bool,
);

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'popularity': instance.popularity,
      'known_for_department': instance.knownForDepartment,
      'gender': instance.gender,
      'adult': instance.adult,
    };
