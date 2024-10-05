import 'package:flutter/material.dart';

class Category {
  final String label;
  final Icon icon;
  final String rawSvg;

  const Category({
    required this.label,
    required this.icon,
    required this.rawSvg
  });
}