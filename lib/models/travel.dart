import 'dart:typed_data';

class Travel {
  final int? id;
  final String name;
  final Uint8List? image; 
  final String dateStart;
  final String dateEnd;
  final String notes;

  const Travel({
    required this.id,
    required this.name,
    required this.image,
    required this.dateStart,
    required this.dateEnd,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'date_start': dateStart,
      'date_end': dateEnd,
      'notes': notes,
    };
  }
}