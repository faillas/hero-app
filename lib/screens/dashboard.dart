import 'package:flutter/material.dart';
import 'package:test_drive/services/note_service.dart';
import 'package:test_drive/services/travel_service.dart';
import 'package:test_drive/services/wishlist_service.dart';
import 'package:test_drive/widgets/bottom_menu.dart';
import 'package:test_drive/widgets/dashboard_slider.dart';
import 'package:test_drive/widgets/graphs/costs.dart';
import 'package:test_drive/widgets/graphs/travels_line.dart';
import 'package:test_drive/widgets/topbar.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late TravelService travelservice  = getIt.get<TravelService>();
  late NoteService noteService  = getIt.get<NoteService>();
  late WishlistService wishService  = getIt.get<WishlistService>();
  late List travels;
  late List budgets = [];
  late List notes = [];
  late List wishlist = [];
  Map? counters;

  void getValues() async {
    travels = await travelservice.loadTravels();
    notes = await noteService.load();
    wishlist = await wishService.load();
    budgets = await travelservice.getTravelsCosts();
    // setState(() {
      
    // });
  }

  @override
  void initState() {
    getValues();   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(title:AppLocalizations.of(context)!.dashboard, father:true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:135, child:  GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [ 
                  buildCard(
                    Column(children: [
                      Text(AppLocalizations.of(context)!.viaggi, 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: travelservice.loadTravels(), 
                        builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                            travels.length.toString(), 
                            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)
                          )
                      )                  
                    ],)
                  ),
                  buildCard(
                    Column(children: [
                      Text(AppLocalizations.of(context)!.note, 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: noteService.load(), 
                        builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                            notes.length.toString(), 
                            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)
                          )
                      )                  
                    ],)
                  ),
                  buildCard(
                    Column(children: [
                       Text(AppLocalizations.of(context)!.wishlist, 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: wishService.load(), 
                        builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                            wishlist.length.toString(), 
                            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)
                          )
                      )                   
                    ],)
                  )               
                ]
              ),
            ),
            const DashboardSlider(),
            buildCard(
              Column(children: [
                Text(AppLocalizations.of(context)!.viaggi, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                FutureBuilder(
                  future: travelservice.loadTravels(), 
                  builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : TravelsLine(travels: travels)
                )      
                
                
              ],)
            ),
            buildCard(
               Column(children: [
                Text(AppLocalizations.of(context)!.spesePerViaggio, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                FutureBuilder(
                  future: travelservice.getTravelsCosts(), 
                  builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : Costs(budgets: budgets)
                )                
              ],)
            )   
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget buildCard(Widget graph) {
    return Card(
      color:Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).dividerColor, // Define the border color
          width: 0.5,           // Define the border width
        ),
      ),
      elevation: 4,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: graph,
          ),
        ),
      );
  }
}
