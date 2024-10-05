import 'package:flutter/material.dart';

class Slide {
  final String label;
  final Icon icon;
  final Color background;
  final Color textColor;
  final String url;

  const Slide({
    required this.label,
    required this.icon,
    required this.background,
    required this.textColor,
    required this.url
  });
}