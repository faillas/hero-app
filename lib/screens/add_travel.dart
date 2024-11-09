import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hero/helpers/date_manager.dart';
import 'package:hero/helpers/validation_manager.dart';
import 'package:hero/models/budget.dart';
import 'package:hero/models/cover.dart';
import 'package:hero/models/plan.dart';
import 'package:hero/models/travel.dart';
import 'package:hero/palette.dart';
import 'package:hero/services/travel_service.dart';
import 'package:hero/widgets/bottom_menu.dart';
import 'package:hero/widgets/cover_travel.dart';
import 'package:hero/widgets/date_range_input.dart';
import 'package:hero/widgets/input_date.dart';
import 'package:hero/widgets/input_time.dart';
import 'package:hero/widgets/budget_list.dart';
import 'package:hero/widgets/plan_list.dart';
import 'package:hero/widgets/section_header.dart';
import 'package:hero/widgets/select_category.dart';
import 'package:hero/widgets/topbar.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class AddTravel extends StatefulWidget {
  const AddTravel({super.key});
  static const routeName = '/add-travel';

  @override
  State<AddTravel> createState() => _AddTravelState();
}

class _AddTravelState extends State<AddTravel> {
  DateManager dateManager = getIt.get<DateManager>();
  ValidationManager validate = getIt.get<ValidationManager>();
  late TravelService service  = getIt.get<TravelService>();
  final TextEditingController destinationController = TextEditingController();
  String startDate = DateTime.now().toString();
  String endDate = DateTime.now().add(const Duration(days: 5)).toString();
  Uint8List? image;
  String? imageExtension;
  final TextEditingController budgetCategoryController = TextEditingController();
  final TextEditingController budgetNameController = TextEditingController();
  final TextEditingController budgetPriceController = TextEditingController();
  final TextEditingController budgetEstimateController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? startDatePlan = DateTime.now();
  String? timePlan;
  String? categoryPlan;

  List<Budget> budgetItems = [];
  List<Plan> planItems = [];

  @override
  void initState() {
    startDate = dateManager.formatStringFromDate(startDate);
    endDate = dateManager.formatStringFromDate(endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(title:AppLocalizations.of(context)!.nuovoViaggio, father:true,),
      body: Column(
        children: [
          CoverTravel(detail: false, onSaveFunction: (Uint8List bytes, String extension){
            setState(() {
              image = bytes;
              imageExtension = extension;
            });
          }),          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(height: 0.5, color: Theme.of(context).dividerColor,),
                       SectionHeader(title:AppLocalizations.of(context)!.doveVuoiAndare),
                      _buildTextField(destinationController, AppLocalizations.of(context)!.nome),
                      Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Theme.of(context).dividerColor,),  
                      SizedBox(
                        height: 55,
                        child: DateRangeInput(
                          label: '',
                          height: 60,
                          onSaveFunction: (DateTimeRange value) {
                            final dates = dateManager.getDatesFromRange(value.toString());
                            setState(() {
                              startDate = dateManager.formatStringFromDate(dates[0]);
                              endDate = dateManager.formatStringFromDate(dates[1]);
                            });
                          },
                        ),
                      ),   
                    ]),
                  Container(height: 0.5, color: Theme.of(context).dividerColor,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(title:AppLocalizations.of(context)!.budget),
                      _buildTextField(budgetNameController, AppLocalizations.of(context)!.nome),
                      Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Theme.of(context).dividerColor,),   
                      Row(children: [
                        Expanded(child: _buildNumberField(budgetEstimateController, AppLocalizations.of(context)!.preventivo)),
                        Container(height: 55, color: Theme.of(context).dividerColor, width: 0.5,),
                        Expanded(child: _buildNumberField(budgetPriceController, AppLocalizations.of(context)!.prezzo)),
                      ],),
                      Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Theme.of(context).dividerColor,),  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              var date = dateManager.getFormattedDateString(DateTime.now().toString());
                              var budget = Budget(
                                id: null, 
                                travelId: null,
                                name: budgetNameController.text, 
                                estimate: budgetEstimateController.text, 
                                value: budgetPriceController.text,
                                createdAt: date,
                              );
                              if(validate.budgetValidation(budget)){
                                budgetItems.add(budget);
                                budgetCategoryController.clear();
                                budgetNameController.clear();
                                budgetEstimateController.clear();
                                budgetPriceController.clear();                             
                                setState(() {});
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    backgroundColor: Palette.danger,
                                    content: Text(AppLocalizations.of(context)!.specificarePrezzoENome),
                                  ),
                                );
                              }
                            },
                            
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width *0.9,
                              height: 55,
                              child:  Padding(
                                padding: const EdgeInsets.only(bottom:0.0, top:18.0, left: 8.0, right: 8.0),
                                child: Text(AppLocalizations.of(context)!.aggiungi, textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 0.5, color: Theme.of(context).dividerColor,),
                      BudgetList(items:budgetItems, trailingKey:AppLocalizations.of(context)!.prezzo, onDelete: (Budget item){
                        budgetItems.remove(item);
                      },),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SectionHeader(title:AppLocalizations.of(context)!.pianificazioneGiornaliera),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDate(start:startDate, end:endDate, onSaveFunction: (DateTime value) {
                            setState(() {
                              startDatePlan = value;
                            });
                          },
                            onError: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Palette.danger,
                                  content: Text(AppLocalizations.of(context)!.dataNonCompresa),
                                ),
                              );
                            },
                          ),  
                          Container(height: 50, color: Theme.of(context).dividerColor, width: 0.5,),   
                          Expanded(child: InputTime(onSaveFunction: (String value) {
                            setState(() {
                              timePlan = value;
                            });
                          },)),                
                        ],
                      ),
                      Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Theme.of(context).dividerColor,),  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildTextField(planNameController, AppLocalizations.of(context)!.nome)),
                        ],
                      ),
                      Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Theme.of(context).dividerColor,),         
                      SelectCategory(
                        onSaveFunction: (String value) {
                          setState(() {
                            categoryPlan = value;
                          });
                        },
                      ),
                      Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Theme.of(context).dividerColor,),  
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                var plan =Plan(
                                  id: null, 
                                  travelId: null, 
                                  date: startDatePlan.toString(), 
                                  hourStart: timePlan.toString(),
                                  description: planNameController.text,
                                  category: categoryPlan,
                                );
                                if(validate.planValidation(plan)){
                                  planItems.add(plan);
                                  planNameController.clear();                            
                                  setState(() {});
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                      backgroundColor: Palette.danger,
                                      content: Text(AppLocalizations.of(context)!.specificareDescrizione),
                                    ),
                                  );
                                }               
                              });
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width *0.9,
                              height: 55,
                              child:  Padding(
                                padding: const EdgeInsets.only(bottom:0.0, top:18.0, left: 8.0, right: 8.0),
                                child: Text(AppLocalizations.of(context)!.aggiungi, textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor)),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      Container(height: 0.5, color: Theme.of(context).dividerColor,),
                      PlanList(items:planItems, trailingKey:AppLocalizations.of(context)!.data, onDelete: (Plan item){
                        planItems.remove(item);
                      },),
                    ],
                  ),
                  Container(height: 0.5, color: Theme.of(context).dividerColor,),
                  Column(children: [
                     SectionHeader(title:AppLocalizations.of(context)!.note),
                    _buildTextField(notesController, AppLocalizations.of(context)!.aggiungiUnaNota, maxLines: 3),
                  ],),
              ],),
            ),
          ),
          GestureDetector(
            onTap: (){
              final travel = Travel(
                id: null, 
                name: destinationController.text, 
                image: image, 
                dateStart: startDate,
                dateEnd: endDate,
                notes: notesController.text,
              );   
              if(validate.travelValidation(travel)){
                Cover? cover =  Cover(id: null, travelId: null, image: image, extension: imageExtension);
                service.save(travel, budgetItems, planItems, cover);
                Navigator.of(context).pushReplacementNamed('/travels');
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    backgroundColor: Palette.danger,
                    content: Text(AppLocalizations.of(context)!.specificareNomeEData),
                  ),
                );
              }             
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Palette.successColor,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.salva,
                    style: const TextStyle(color:Palette.white,fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    bottomNavigationBar: const BottomNavBar(),
    );
  }


  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color:Theme.of(context).hintColor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildNumberField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color:Theme.of(context).hintColor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
      ),
      maxLines: maxLines,
    );
  }

  
}
