import 'package:flutter/foundation.dart';

class Cover {
  final int? id;
  final int? travelId;
  final Uint8List? image;
  final String? extension;

  const Cover({
    required this.id,
    required this.travelId,
    required this.image,
    required this.extension,
  });
}