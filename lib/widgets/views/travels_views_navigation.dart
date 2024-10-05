import 'package:flutter/material.dart';
import 'package:test_drive/palette.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/providers/travels_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TravelsViewsNavigation extends StatefulWidget {
  const TravelsViewsNavigation({super.key});

  @override
  State<TravelsViewsNavigation> createState() => _TravelsViewsNavigationState();
}

class _TravelsViewsNavigationState extends State<TravelsViewsNavigation> {

  @override
  Widget build(BuildContext context) {
    final viewProvider = Provider.of<TravelsProvider>(context, listen: false);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () {
              viewProvider.changeView('gallery');
              setState((){});
            },
            icon: const Icon(Icons.photo_library_outlined),
            label: Text(AppLocalizations.of(context)!.galleria, style: TextStyle(color:viewProvider.view =='gallery' ?  Palette.white: Colors.grey),),
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: viewProvider.view =='gallery' ?  Palette.white : Colors.grey),
              iconColor:viewProvider.view =='gallery' ? Palette.white : Colors.grey,
              backgroundColor:viewProvider.view =='gallery' ?  Palette.primary :Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0), // Small border radius
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              viewProvider.changeView('bacheca');
              setState((){});
            },
            icon: const Icon(Icons.copy_outlined),
            label: Text(AppLocalizations.of(context)!.bacheca, style: TextStyle(color:viewProvider.view =='bacheca' ?  Palette.white: Colors.grey),),
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: viewProvider.view =='bacheca' ?  Palette.white : Colors.grey),
              iconColor:viewProvider.view =='bacheca' ? Palette.white : Colors.grey,
              backgroundColor:viewProvider.view =='bacheca' ?  Palette.primary :Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0), // Small border radius
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              viewProvider.changeView('timeline');
              setState((){});
            },
            icon: const Icon(Icons.flag_outlined),
            label: Text(AppLocalizations.of(context)!.timeline, style: TextStyle(color:viewProvider.view =='timeline' ?  Palette.white: Colors.grey),),
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: viewProvider.view =='timeline' ?  Palette.white : Colors.grey),
              iconColor:viewProvider.view =='timeline' ? Palette.white : Colors.grey,
              backgroundColor:viewProvider.view =='timeline' ?  Palette.primary :Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0), // Small border radius
              ),
            ),
          ),
          const SizedBox(width: 4,)
        ],
      ),
    );
  }
}