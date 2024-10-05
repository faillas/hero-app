import 'package:flutter/material.dart';
import 'package:test_drive/helpers/file_manager.dart';
import 'package:test_drive/models/budget.dart';
import 'package:test_drive/models/plan.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/providers/travels_provider.dart';
import 'package:test_drive/services/travel_service.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class SelectActionTravel extends StatefulWidget {
  final Function onSelect;
  const SelectActionTravel({super.key, required this.onSelect});

  @override
  State<SelectActionTravel> createState() => _SelectActionTravelState();
}

class _SelectActionTravelState extends State<SelectActionTravel> {
  late TravelService service  = getIt.get<TravelService>();
  FileManager fileManager = getIt.get<FileManager>();
  late final provider = Provider.of<TravelsProvider>(context, listen: false);
  late List<Budget> budgetItems = [];
  late List<Plan> planItems = [];
  
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor:Theme.of(context).primaryColor,
          icon:  Icon(Icons.error_outline_outlined, 
            size: 100, 
            color: Theme.of(context).highlightColor
          ),
          content: Text(
            AppLocalizations.of(context)!.sicuroDiEliminareViaggio,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(AppLocalizations.of(context)!.annulla),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(color: Colors.white),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Set border radius here
                ),
              ),
              child: Text(AppLocalizations.of(context)!.conferma),
              onPressed: () {
                Navigator.of(context).pop();
                final id = provider.travel!.id;
                provider.clearDetail();
                service.deleteTravel(id);
                setState(() {});
                widget.onSelect();
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap:(){
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/travel-detail');
          },
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width *0.09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.folder_open_outlined, color:Palette.successColor, size:30),
                Text(AppLocalizations.of(context)!.vedi, style: const TextStyle(color: Palette.successColor,fontWeight: FontWeight.w600, fontSize: 10),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap:(){
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/edit-travel');
          },
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width *0.09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.edit, color:Palette.primary, size:30),
                Text(AppLocalizations.of(context)!.edit, style: const TextStyle(color: Palette.primary,fontWeight: FontWeight.w600, fontSize: 10),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap:(){
            _dialogBuilder(context);        
          },
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width *0.09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.delete_outlined, color:Palette.danger, size:30),
                Text(AppLocalizations.of(context)!.elimina, style: const TextStyle(color: Palette.danger,fontWeight: FontWeight.w600, fontSize: 10),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap:() async{
            budgetItems = await service.loadBudgets(provider.travel!.id);
            if(provider.travel != null){
              fileManager.generateCostsList(provider.travel!, budgetItems);
            }
          },
          child:  SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width *0.09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.receipt_long_outlined, color:Palette.info, size:30),
                Text(AppLocalizations.of(context)!.costi, style: const TextStyle(color: Palette.info,fontWeight: FontWeight.w600, fontSize: 10),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap:() async{
            planItems = await service.loadPlans(provider.travel!.id);
            if(provider.travel != null){
              fileManager.generatePlan(provider.travel!, planItems);
            }
          },
          child:  SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width *0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.explore, color:Palette.info, size:30),
                Text(AppLocalizations.of(context)!.itinerari, style: const TextStyle(color: Palette.info,fontWeight: FontWeight.w600, fontSize: 10),)
              ],
            ),
          ),
        ),
      ],
    );
  }
}