import 'package:flutter/material.dart';
import 'package:hero/screens/dashboard.dart';
import 'package:hero/screens/on_boarding.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/services/config_service.dart';

GetIt getIt = GetIt.instance;

class FirstLoadChecker extends StatefulWidget {
  static const routeName = '/first-load';

  const FirstLoadChecker({super.key});

  @override
  _FirstLoadCheckerState createState() => _FirstLoadCheckerState();
}

class _FirstLoadCheckerState extends State<FirstLoadChecker> {
  late ConfigService configservice  = getIt.get<ConfigService>();
  late List configurations = []; 
  bool firstLoad = false;

  @override
  void initState() {
    super.initState();  
  }

  // Check if it's the first time the app is loaded
  Future<dynamic> _checkFirstLoad() async {
    configurations = await configservice.getConfig();
    for (var row in configurations) { 
      if(row.name== 'first_load'){
        firstLoad = row.value == 1? true : false;
      }
    }
    return firstLoad;
  }

  void _completeOnboarding() {
    firstLoad = false;
    setState(() {});
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkFirstLoad(), 
      builder: (context, snapshot)=> snapshot.connectionState == ConnectionState.waiting
        ? const Center(child: CircularProgressIndicator())
        : (firstLoad == true)
          ? OnBoarding(onComplete: _completeOnboarding) 
          : const DashboardPage()
    ); 
    

  }
}