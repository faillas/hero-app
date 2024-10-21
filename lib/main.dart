import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hero/animations.dart';
import 'package:hero/bootstrap.dart';
import 'package:hero/providers/theme_provider.dart';
import 'package:hero/screens/first_load.dart';
import 'package:hero/screens/add_travel.dart';
import 'package:hero/screens/dashboard.dart';
import 'package:hero/screens/edit_travel.dart';
import 'package:hero/screens/notes.dart';
import 'package:hero/screens/travel_detail.dart';
import 'package:hero/screens/travels.dart';
import 'package:hero/screens/wishlist.dart';
import 'package:hero/services/config_service.dart';
import 'palette.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

void main() {
  bootstrap();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero: your travels in one click',
      theme: ThemeData(     
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConfigService configservice  = getIt.get<ConfigService>();
  late final provider = Provider.of<ThemeProvider>(context, listen: false);
  List<dynamic> themes = [];
  
  Future<void> getActiveTheme() async{
    themes = await configservice.loadThemes();
    for(var theme in themes){
      if(theme.active == 1){
        provider.changeTheme(theme.name);
      }
    }
    setState(() {     
    });  
  }

  @override
  void initState() {
    getActiveTheme();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) { 

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hero: your travels in one click',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('it'),
            Locale('fr'),
            Locale('es'),
            Locale('de'),
          ],
          theme: ThemeData(         
            primaryColor: Colors.white,
            dividerColor: Colors.black.withOpacity(0.5),
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor:Palette.white,
            highlightColor: Palette.primary,
            focusColor: Palette.primary,
            hintColor: Colors.black,
            hoverColor: Palette.primary,
             appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue, // AppBar background for light theme
              foregroundColor: Colors.white, // AppBar text/icon color for light theme
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white, // Light theme background
              selectedItemColor: Colors.red, // Light theme selected item color
              unselectedItemColor: Colors.grey, // Light theme unselected item color
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black), // Text color for light theme
              bodyMedium: TextStyle(color: Colors.black),
            ),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            })),
          darkTheme: ThemeData(    
            primaryColor: const Color.fromARGB(255, 7, 38, 83), 
            dividerColor: Colors.white.withOpacity(0.5),// Dark primary color
            scaffoldBackgroundColor: const Color.fromARGB(255, 7, 38, 83),
            hintColor: Colors.white,
            highlightColor: Palette.accent,
            focusColor: Palette.accent,
            hoverColor: Palette.accent,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 7, 38, 83), // AppBar background for dark theme
              foregroundColor: Colors.white, // AppBar text/icon color for dark theme
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 7, 38, 83), // Dark theme background
              selectedItemColor: Colors.yellow, // Dark theme selected item color
              unselectedItemColor: Colors.grey, // Dark theme unselected item color
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white), // Text color for dark theme
              bodyMedium: TextStyle(color: Colors.white),
            ),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            })),
          themeMode: themeProvider.mode,
          initialRoute: '/',
          routes: {
            "/": (context) => const FirstLoadChecker(),
            FirstLoadChecker.routeName : (context) => const FirstLoadChecker(),
            AddTravel.routeName : (context) => const AddTravel(),
            EditTravel.routeName : (context) => const EditTravel(),
            DashboardPage.routeName : (context) => const DashboardPage(),
            Travels.routeName: (context) => const Travels(),
            Notes.routeName : (context) => const Notes(),
            TravelDetail.routeName : (context) => const TravelDetail(),
            WishList.routeName : (context) => const WishList(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
                builder: (context) =>
                  const FirstLoadChecker());
          }
        );
      }
    );
  }
}
