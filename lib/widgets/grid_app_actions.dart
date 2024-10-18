import 'package:flutter/material.dart';
import 'package:hero/palette.dart';
import 'package:hero/widgets/slide_dashboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GridAppActions extends StatelessWidget {
  const GridAppActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:300, child:  GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                scrollDirection: Axis.horizontal,
                children: [ 
                  SlideDashboard(
          text: AppLocalizations.of(context)!.pianificaNuoviViaggi,
          icon: const Icon(Icons.add_box_outlined, size:60, color: Colors.black),
          background: Palette.accent,
          textColor: Colors.black,
          url:'/add-travel'
        ),
        SlideDashboard(
          text: AppLocalizations.of(context)!.vediTuttiITuoiViaggi,
          icon: const Icon(Icons.flight, size:60, color: Palette.contentInfo),
          background: Palette.info,
          textColor: Palette.contentInfo,
          url:'/destinations-card-view'
        ),
        SlideDashboard(
          text: AppLocalizations.of(context)!.creaUnaLista,
          icon: const Icon(Icons.playlist_add_check, size:60, color: Palette.white),
          background: Palette.primary,
          textColor: Palette.white,
          url:'/wishlist'
        ),
        SlideDashboard(
          text: AppLocalizations.of(context)!.creaUnaBachecaVirtuale,
          icon: const Icon(Icons.attach_file, size:60, color: Palette.white),
          background: Palette.successColor,
          textColor: Palette.white,
          url:'/notes'
        )               
                ]
              ),
            );
  }
}