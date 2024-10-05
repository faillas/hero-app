// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../palette.dart';

class WarningMessage extends StatelessWidget {
  final String message;
  double? height;

  WarningMessage({super.key, required this.message, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 100,
              color: Palette.contentWarning,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                message,
                style: TextStyle(fontSize: 18, color: Palette.contentWarning),
              ),
            ),
          ],
        )));
  }
}
