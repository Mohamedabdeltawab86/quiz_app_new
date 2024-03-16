// TODO: 1. create path module
// ###ID , List<String> coursesIds, Path name, created_at, updated_at
class Path {
  String? id;
  List<String> coursesIds;
  String name;
  DateTime createdAt;
  DateTime? updatedAt;

  Path({
    this.id,
    required this.coursesIds,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  
}