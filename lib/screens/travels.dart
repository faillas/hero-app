import 'package:flutter/material.dart';
import 'package:test_drive/widgets/bottom_menu.dart';
import 'package:test_drive/widgets/topbar.dart';
import 'package:test_drive/widgets/travels_view.dart';
import 'package:test_drive/widgets/views/travels_views_navigation.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class Travels extends StatelessWidget {
  const Travels({super.key});
  static const routeName = '/travels';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(title:AppLocalizations.of(context)!.viaggi, father:true),
      bottomNavigationBar: const BottomNavBar(),
      body: Column(children: [
        const TravelsViewsNavigation(),
        SizedBox(
          height: MediaQuery.of(context).size.height *0.76,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: TravelsView()
            ),
          )
      ])     
    );
  }
}