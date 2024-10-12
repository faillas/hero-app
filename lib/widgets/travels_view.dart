import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hero/providers/travels_provider.dart';
import 'package:hero/services/travel_service.dart';
import 'package:hero/widgets/views/destinations_card_view.dart';
import 'package:hero/widgets/views/destinations_timeline.dart';
import 'package:hero/widgets/views/gallery.dart';
import 'package:hero/widgets/warning_message.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class TravelsView extends StatefulWidget {
  const TravelsView({super.key});

  @override
  State<TravelsView> createState() => _TravelsViewState();
}

class _TravelsViewState extends State<TravelsView> {
  late TravelService service  = getIt.get<TravelService>();
  List _travels = [];

  Future<List> loadTravels() async {
    return _travels = await service.loadTravels();
  }

  @override
  void initState() {
    loadTravels();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadTravels(),
      builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
        ?const Center(child: CircularProgressIndicator())
        :Consumer<TravelsProvider>(
          builder: (context, viewProvider, child){
            if(_travels.isNotEmpty){
              switch (viewProvider.view) {
                case 'timeline':
                  return DestinationsTimeline(
                    travels: _travels,
                    onUpdate: (){
                      loadTravels();
                      setState(() {});
                    },
                  );
                case 'gallery':
                  return Gallery(travels: _travels);
                case 'bacheca':
                  return DestinationsCardView(
                    travels: _travels,
                    onUpdate: (){
                      loadTravels();
                      setState(() {
                        
                      });
                    },
                  );
                default:
                  return DestinationsCardView(
                    travels:_travels,
                    onUpdate: (){
                      loadTravels();
                      setState(() {});
                    },
                  );
              }
            }else{
              return WarningMessage(message: AppLocalizations.of(context)!.nonCiSonoViaggiRegistrati);
            }
          }  
        )
    );
  }
}