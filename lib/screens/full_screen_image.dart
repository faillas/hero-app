import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/widgets/cover_travel.dart';
import 'package:test_drive/widgets/topbar.dart';


class FullScreenImage extends StatelessWidget {
  final Uint8List image;
  final String title;
  const FullScreenImage({required this.image, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: Topbar(title: title, father:false),
      body: Container(
        color: Palette.neutral,
        height: MediaQuery.of(context).size.height *0.9,
        child: Expanded(
          child: CoverTravel(
            detail: true,
            fullScreen: true,
            cover: image,
            travel: title,
            onSaveFunction: null,
          ),
        ),
      ),
    );
  }
}