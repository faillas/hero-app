import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor white =  MaterialColor(
    0xffFFFFFF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xffffffff),
      100: Color(0xffd0d0d0),
      200: Color(0xffd0d0d0),
      300: Color(0xffa2a2a2),
      400: Color(0xffa2a2a2),
      500: Color(0xff777777),
      600: Color(0xff777777),
      700: Color(0xff4e4e4e),
      800: Color(0xff4e4e4e),
      900: Color(0xff000000),
    },
  );

  static const MaterialColor dark =  MaterialColor(
    0xff325082, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xff325082),
      100: Color(0xff2d4875),
      200: Color(0xff284068),
      300: Color(0xff23385b),
      400: Color(0xff1e304e),
      500: Color(0xff192841),
      600: Color(0xff142034),
      700: Color(0xff0f1827),
      800: Color(0xff0a101a),
      900: Color(0xff05080d),
    },
  );

  static const MaterialColor primary = MaterialColor(
    0xff337AB7, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xff2e6ea5), //10%
      100: Color(0xff296292), //20%
      200: Color(0xff245580), //30%
      300: Color(0xff1f496e), //40%
      400: Color(0xff1a3d5c), //50%
      500: Color(0xff143149), //60%
      600: Color(0xff0f2537), //70%
      700: Color(0xff0a1825), //80%
      800: Color(0xff050c12), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const MaterialColor info =  MaterialColor(
    0xFF00BCD4,
    <int, Color>{
      50: Color(0xFFE0F7FA),
      100: Color(0xFFB2EBF2),
      200: Color(0xFF80DEEA),
      300: Color(0xFF4DD0E1),
      400: Color(0xFF26C6DA),
      500: Color(0xFF00BCD4),
      600: Color(0xFF00ACC1),
      700: Color(0xFF0097A7),
      800: Color(0xFF00838F),
      900: Color(0xFF006064),
    },
  );
  static const Color contentInfo = Color(0xff003a58);

  static const MaterialColor secondary =  MaterialColor(
    0xffFB1A1A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xffe21717), //10%
      100: Color(0xffc91515), //20%
      200: Color(0xffb01212), //30%
      300: Color(0xff971010), //40%
      400: Color(0xff7e0d0d), //50%
      500: Color(0xff640a0a), //60%
      600: Color(0xff4b0808), //70%
      700: Color(0xff320505), //80%
      800: Color(0xff190303), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const MaterialColor danger =  MaterialColor(
    0xffFB1A1A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
     <int, Color>{
      50:  Color(0xffe21717), //10%
      100:  Color(0xffc91515), //20%
      200:  Color(0xffb01212), //30%
      300:  Color(0xff971010), //40%
      400:  Color(0xff7e0d0d), //50%
      500:  Color(0xff640a0a), //60%
      600:  Color(0xff4b0808), //70%
      700:  Color(0xff320505), //80%
      800:  Color(0xff190303), //90%
      900:  Color(0xff000000), //100%
    },
  );

  static const MaterialColor neutral =  MaterialColor(
    0xff3D4856, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xff37414d), //10%
      100: Color(0xff313a45), //20%
      200: Color(0xff2b323c), //30%
      300: Color(0xff252b34), //40%
      400: Color(0xff1f242b), //50%
      500: Color(0xff181d22), //60%
      600: Color(0xff4b0808), //70%
      700: Color(0xff12161a), //80%
      800: Color(0xff060709), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const MaterialColor accent =  MaterialColor(
    0xffFBBD23, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
     <int, Color>{
      50:  Color(0xfffbbd23), //10%
      100: Color(0xffe2aa20), //20%
      200: Color(0xffb08419), //30%
      300: Color(0xff977115), //40%
      400: Color(0xff7e5f12), //50%
      500: Color(0xff644c0e), //60%
      600: Color(0xff4b390a), //70%
      700: Color(0xff322607), //80%
      800: Color(0xff191303), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const Color contentPrimary = Colors.white;
  static const MaterialColor warning =  MaterialColor(
    0xffFBBD23, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xfffbbd23), //10%
      100: Color(0xffe2aa20), //20%
      200: Color(0xffb08419), //30%
      300: Color(0xff977115), //40%
      400: Color(0xff7e5f12), //50%
      500: Color(0xff644c0e), //60%
      600: Color(0xff4b390a), //70%
      700: Color(0xff322607), //80%
      800: Color(0xff191303), //90%
      900: Color(0xff000000), //100%
    },
  );

  static Color contentWarning = warning.shade200;
  static Color contentDanger = Colors.white;

  static const MaterialColor successColor = Colors.green;
  static Color contentSuccessColor = Colors.green.shade800;

  static const bgIconsDefault = Colors.cyan;
  static const colorIconsDefault = Palette.neutral;

  static Color bgColorFilters = Colors.black.withOpacity(0.8);
  static Color contentOnColorFilters = Colors.white;
}