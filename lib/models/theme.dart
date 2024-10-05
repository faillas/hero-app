
class Tema {
  final int? id;
  final String name;
  final int active; 

  const Tema({
    required this.id,
    required this.name,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'active': active,
    };
  }
}