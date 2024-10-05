// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex = 0;

  void setIndex(context){
    String url = ModalRoute.of(context)!.settings.name.toString();
    switch (url) {
      case '/dashboard':
        _currentIndex = 0;
        break;
      case '/travels': case '/edit-travel':
        _currentIndex = 1;
        break;
      case '/add-travel':
        _currentIndex = 2;
        break;
      case '/wishlist':
        _currentIndex = 3;
        break;
      case '/notes':
        _currentIndex = 4;
        break;
      default: _currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    setIndex(context);
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      currentIndex: _currentIndex,
      onTap: (index) {
        String url = '';
        switch (index) {
          case 0:
            url = '/dashboard';
            break;
          case 1:
            url = '/travels';
            break;
          case 2:
            url = '/add-travel';
            break;
          case 3:
            url = '/wishlist';
            break;
          case 4:
            url = '/notes';
            break;
          default:
        }
        setState(() {
          _currentIndex = index;
          Navigator.of(context).pushReplacementNamed(url);
        });
        // Handle navigation based on the tapped item
      },
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          icon: const Icon(Icons.dashboard),
          label: AppLocalizations.of(context)!.dashboard,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          icon:  const Icon(Icons.flight),
          label: AppLocalizations.of(context)!.viaggi,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          icon:  const Icon(Icons.add_box_outlined),
          label: AppLocalizations.of(context)!.nuovoViaggio,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          icon:  const Icon(Icons.playlist_add_check),
          label: AppLocalizations.of(context)!.wishlist,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          icon:  const Icon(Icons.attach_file),
          label: AppLocalizations.of(context)!.note,
        ),
      ],
      
    );
  }
}
