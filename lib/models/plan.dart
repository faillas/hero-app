
class Plan {
  final int? id;
  final int? travelId;
  final String date;
  final String hourStart;
  final String description;
  final String? category;

  const Plan({
    required this.id,
    required this.travelId,
    required this.date,
    required this.hourStart,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'travel_id': travelId,
      'date': date,
      'hour_start': hourStart,
      'description': description,
      'category': category   
    };
  }
}