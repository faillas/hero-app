import 'package:flutter/material.dart';
import 'package:test_drive/models/slide.dart';
import 'package:test_drive/palette.dart';


final List<Slide> slides = [
  const Slide(
      label: 'Pianifica nuovi viaggi',
      icon: Icon(Icons.add_box_outlined, size:60, color: Colors.black),
      background: Palette.accent,
      textColor: Colors.black,
      url: '/add-travel', 
  ),
  const Slide(
      label: 'Vedi tutti i tuoi viaggi in un\'unica timeline, in bacheca o in galleria',
      icon: Icon(Icons.flight, size:60, color: Palette.contentInfo),
      background: Palette.info,
      textColor:Palette.contentInfo,
      url: '/destinations-card-view', 
  ),
  const Slide(
      label: 'Crea una lista di cose da fare prima e dopo i tuoi viaggi',
      icon: Icon(Icons.playlist_add_check, size:60, color: Palette.white),
      background: Palette.primary,
      textColor:Palette.white,
      url: '/wishlist', 
  ), 
  const Slide(
      label: 'Crea una bacheca virtuale per annotare tutto ciò che può esserti utile',
      icon: Icon(Icons.attach_file, size:60, color: Palette.white),
      background: Palette.successColor,
      textColor:Palette.white,
      url: '/notes', 
  ), 
  
];
