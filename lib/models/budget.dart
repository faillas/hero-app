class Budget {
  final int? id;
  final int? travelId;
  final String name;
  final String estimate;
  final String value;
  final String createdAt;

  const Budget({
    required this.id,
    required this.travelId,
    required this.name,
    required this.estimate,
    required this.value,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'travel_id': travelId,
      'name': name,
      'estimate': estimate,
      'price': value,
      'created_at': createdAt,
    };
  }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return createdAt;
      case 1:
        return name;
      case 2:
        return estimate;
      case 3:
        return value;
    }
    return '';
  }
}