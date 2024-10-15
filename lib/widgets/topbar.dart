import 'package:flutter/material.dart';
import 'package:hero/providers/travels_provider.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/widgets/section_header.dart';
import 'package:hero/widgets/select_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class Topbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? bgColor;
  final Color? fgColor;
  final bool father;
  final bool? create;
  final bool? detail;
  final bool? notifications;
  final VoidCallback? onSave;
  final double? elevation;

  const Topbar(
      {super.key,
      required this.title,
      required this.father,
      this.create,
      this.notifications,
      this.detail,
      this.elevation,
      this.onSave,
      this.bgColor,
      this.fgColor});

      

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelsProvider>(context, listen: true);

    void showBottomDialog(dialogContext) {
      showModalBottomSheet(
        barrierColor: Colors.white,
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext dialogContext) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Palette.info.withOpacity(0.25),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.impostazioni,
                      style: const TextStyle(color: Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(AppLocalizations.of(context)!.temaApplicazione, textAlign: TextAlign.left, 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                      ),
                      const SizedBox(height: 20,),
                      const SelectTheme()
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return AppBar(
        leading: (father==false)? IconButton(
          onPressed: (){ 
            provider.clearDetail();           
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30)
        ): null,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: AppBarTheme.of(context).elevation,
        shadowColor: Colors.black,
        title: Row(children: [
          Image.asset('assets/logo.png', height: 40),         
          const Icon(Icons.chevron_right),
          Text(title, style: const TextStyle(fontSize: 16),), //AppLocalizations.of(context)!.helloWorld
        ]),
        actions: <Widget>[    
          if(father == true)
           IconButton(
                onPressed: ()=>showBottomDialog(context),
                icon: const Icon(Icons.settings, color: Colors.white, size: 30)),
          if (detail == true)
            IconButton(
                onPressed: ()=> Navigator.of(context).pushReplacementNamed('/edit-travel'),
                icon: const Icon(Icons.edit, color: Colors.white, size: 30)),
          if (create == true)
            IconButton(
                onPressed: onSave,
                icon: const Icon(Icons.save, color: Colors.white, size: 30)),
          Container()
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
