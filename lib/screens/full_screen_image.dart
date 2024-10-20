import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hero/palette.dart';
import 'package:hero/widgets/cover_travel.dart';
import 'package:hero/widgets/topbar.dart';


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
        child: CoverTravel(
          detail: true,
          fullScreen: true,
          cover: image,
          travel: title,
          onSaveFunction: null,
        ),
      ),
    );
  }
}