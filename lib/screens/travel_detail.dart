import 'package:flutter/material.dart';
import 'package:test_drive/helpers/file_manager.dart';
import 'package:test_drive/models/budget.dart';
import 'package:test_drive/models/plan.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/providers/travels_provider.dart';
import 'package:test_drive/services/travel_service.dart';
import 'package:test_drive/widgets/budget_list.dart';
import 'package:test_drive/widgets/cover_travel.dart';
import 'package:test_drive/widgets/plan_list.dart';
import 'package:test_drive/widgets/section_header.dart';
import 'package:test_drive/widgets/topbar.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:test_drive/widgets/warning_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class TravelDetail extends StatefulWidget {
  const TravelDetail({super.key});
  static const routeName = '/travel-detail';

  @override
  State<TravelDetail> createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  late TravelService service  = getIt.get<TravelService>();
  late final provider = Provider.of<TravelsProvider>(context, listen: false);
  FileManager fileManager = getIt.get<FileManager>();
  late List<Budget> budgetItems = [];
  late List<Plan> planItems = [];

  void loadTravel() async {
    if(provider.travel != null){
      budgetItems = await service.loadBudgets(provider.travel!.id);
      planItems = await service.loadPlans(provider.travel!.id);
    }
  }

  @override
  void initState() {
    loadTravel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(title:AppLocalizations.of(context)!.dettaglioViaggio, father:false, detail:true),
      body: Column(
        children: [
          CoverTravel(detail:true, cover:provider.travel!.image, travel:provider.travel!.name, onSaveFunction: null),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Palette.neutral.withOpacity(0.75),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${provider.travel!.dateStart} - ${provider.travel!.dateEnd}',
                          style: const TextStyle(fontSize: 15, color: Palette.white),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          provider.travel!.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Palette.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),         
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                  
                  Container(height: 0.5, color: Colors.black.withOpacity(0.5),),
                  SectionHeader(title:AppLocalizations.of(context)!.budgets),
                  FutureBuilder(
                    future: service.loadBudgets(provider.travel!.id),
                    builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : (budgetItems.isNotEmpty)
                      ? Column(children: [
                        BudgetList(
                          items:budgetItems, 
                          isEdit: false, 
                          trailingKey:AppLocalizations.of(context)!.prezzo,
                          onDelete: ()=>null,
                        ),
                        Container(height: 0.5, color: Colors.black.withOpacity(0.5),),
                          GestureDetector(
                            onTap: ()async {
                              //download report
                              if(provider.travel != null){
                                fileManager.generateCostsList(provider.travel!, budgetItems);
                              }
                            },            
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width *0.9,
                              height: 55,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(Icons.download, color: Palette.primary,),
                                  Text(AppLocalizations.of(context)!.reportPDF, textAlign: TextAlign.end, style:const TextStyle(color: Palette.primary)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                      :WarningMessage(message:AppLocalizations.of(context)!.nonCiSonoBudget)
                  ),
                  Container(height: 0.5, color: Colors.black.withOpacity(0.5),),
                  SectionHeader(title:AppLocalizations.of(context)!.pianificazioni),
                  FutureBuilder(
                    future: service.loadPlans(provider.travel!.id), 
                    builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : (planItems.isNotEmpty)
                        ?Column(
                          children: [
                            PlanList(
                              items:planItems, 
                              isEdit: false, 
                              trailingKey:AppLocalizations.of(context)!.data,
                              onDelete: ()=>null,
                            ),
                            Container(height: 0.5, color: Colors.black.withOpacity(0.5),),
                            GestureDetector(
                              onTap: (){
                                //download report
                                if(provider.travel != null){
                                  fileManager.generatePlan(provider.travel!, planItems);
                                }
                              },            
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width *0.9,
                                height: 55,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.download, color: Palette.primary,),
                                    Text(AppLocalizations.of(context)!.reportPDF, textAlign: TextAlign.end, style:const TextStyle(color: Palette.primary)),
                                  ],
                                ),
                              ),
                            ),
                            
                          ],
                        )
                        :WarningMessage(message:AppLocalizations.of(context)!.nonCiSonoPianificazioni)
                  ),                  
                  Container(height: 0.5, color: Colors.black.withOpacity(0.5),),
                  SectionHeader(title:AppLocalizations.of(context)!.note),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          provider.travel!.notes,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
