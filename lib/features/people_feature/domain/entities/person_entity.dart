// Domain Entity - Pure business logic, no dependencies on frameworks
class PersonEntity {
  final int id;
  final String name;
  final String? profilePath;
  final double popularity;
  final String knownForDepartment;
  final int gender;
  final bool adult;

  const PersonEntity({
    required this.id,
    required this.name,
    this.profilePath,
    required this.popularity,
    required this.knownForDepartment,
    required this.gender,
    required this.adult,
  });
}
