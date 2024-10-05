import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/providers/theme_provider.dart';
import 'package:test_drive/services/config_service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class SelectTheme extends StatefulWidget {
  const SelectTheme({ super.key, });

  @override
  State<SelectTheme> createState() => _SelectThemeState();
}

class _SelectThemeState extends State<SelectTheme>{
  late ConfigService configservice  = getIt.get<ConfigService>();
  List<dynamic> themes = [];

  Future<void> getThemes() async{
      themes = await configservice.loadThemes();
      setState(() {});
    }

  @override
  void initState() {
    getThemes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);

    void onThemeSelected(int id, String theme) async {
      configservice.updateTheme(id);
      themes = await configservice.loadThemes();
      provider.changeTheme(theme);
      setState(() {});
    }

    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: (){
            onThemeSelected(1,'light');
          },
          child:Container(   
            decoration: BoxDecoration(
              color: provider.theme == 'light' ?Palette.info.withOpacity(0.8):Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Image.asset('assets/icons/light.png', height: 120),                                                
                Text(AppLocalizations.of(context)!.light,
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: provider.theme == 'light' ?Palette.white: Theme.of(context).highlightColor,
                ))
              ]))
          )      
        ),
        GestureDetector(
          onTap: (){
            onThemeSelected(2,'dark');
          },
          child:Container(   
            decoration: BoxDecoration(
              color: provider.theme == 'dark'?Palette.info.withOpacity(0.8):Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Image.asset('assets/icons/dark.png', height: 120),                                                
                Text(
                  AppLocalizations.of(context)!.dark,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: provider.theme=='dark' ?Palette.white: Theme.of(context).highlightColor,
                ))
              ]))
          )
          
        )
      ]        
    ); 
  }
}