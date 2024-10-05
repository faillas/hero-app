
class Configuration {
  final int? id;
  final String name;
  final int value; 

  const Configuration({
    required this.id,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }
}