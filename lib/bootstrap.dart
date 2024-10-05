import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_drive/helpers/date_manager.dart';
import 'package:test_drive/helpers/file_manager.dart';
import 'package:test_drive/helpers/icon_manager.dart';
import 'package:test_drive/helpers/validation_manager.dart';

import 'package:test_drive/main.dart';
import 'package:get_it/get_it.dart';
import 'package:test_drive/providers/theme_provider.dart';
import 'package:test_drive/providers/travels_provider.dart';
import 'package:test_drive/services/config_service.dart';
import 'package:test_drive/services/note_service.dart';
import 'package:test_drive/services/travel_service.dart';
import 'package:test_drive/services/wishlist_service.dart';

GetIt getIt = GetIt.instance;

bootstrap() async {
  getIt.registerSingleton<NoteService>(NoteService());
  getIt.registerSingleton<TravelService>(TravelService());
  getIt.registerSingleton<WishlistService>(WishlistService());
  getIt.registerSingleton<ConfigService>(ConfigService());
  getIt.registerSingleton<DateManager>(DateManager());
  getIt.registerSingleton<FileManager>(FileManager());
  getIt.registerSingleton<IconManager>(IconManager());
  getIt.registerSingleton<ValidationManager>(ValidationManager());
  runApp(MultiProvider(
    providers: [  
      ChangeNotifierProvider(
        create: (_) => TravelsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
      
    ],
    child:const MyApp()
  ));
}
