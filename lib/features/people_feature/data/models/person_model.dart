// Data Model with JSON Serialization - Single Responsibility Principle (SRP)
// Only responsible for data mapping
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/features/people_feature/domain/entities/person_entity.dart';

part 'person_model.g.dart';

@JsonSerializable()
class PersonModel {
  final int id;
  final String name;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  final double popularity;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final int gender;
  final bool adult;

  const PersonModel({
    required this.id,
    required this.name,
    this.profilePath,
    required this.popularity,
    required this.knownForDepartment,
    required this.gender,
    required this.adult,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);

  // Convert to domain entity - Liskov Substitution Principle (LSP)
  PersonEntity toEntity() {
    return PersonEntity(
      id: id,
      name: name,
      profilePath: profilePath,
      popularity: popularity,
      knownForDepartment: knownForDepartment,
      gender: gender,
      adult: adult,
    );
  }
}
