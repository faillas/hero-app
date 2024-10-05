import 'package:flutter/material.dart';
import 'package:test_drive/widgets/section_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SelectCategory extends StatefulWidget {
  final Function? onSaveFunction;

  const SelectCategory({required this.onSaveFunction, super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  String? selectedItem;

  void selectCategory(label){
    widget.onSaveFunction!(label);
    setState(() {
      selectedItem = label;
    });
  }

  void showBottomDialog() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Column(
          children: [
            SectionHeader(title:AppLocalizations.of(context)!.categorie),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.informazioni);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.infoCircle, size:18),),
                          title: Text(AppLocalizations.of(context)!.informazioni, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.pagamento);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.coins, size:18)),
                          title: Text(AppLocalizations.of(context)!.pagamento, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.volo);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.plane, size:18)),
                          title: Text(AppLocalizations.of(context)!.volo, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.albergo);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.conciergeBell, size:18),),
                          title: Text(AppLocalizations.of(context)!.albergo, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.museo);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.landmark, size:18),),
                          title: Text(AppLocalizations.of(context)!.museo, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.autobus);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.bus, size:18),),
                          title: Text(AppLocalizations.of(context)!.autobus, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.metro);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.train, size:18),),
                          title: Text(AppLocalizations.of(context)!.metro, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.taxi);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.taxi, size:18),),
                          title: Text(AppLocalizations.of(context)!.taxi, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.auto);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.car, size:18),),
                          title: Text(AppLocalizations.of(context)!.auto, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.speciale);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.star, size:18),),
                          title: Text(AppLocalizations.of(context)!.speciale, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.pasto);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.pizzaSlice, size:18),),
                          title: Text(AppLocalizations.of(context)!.pasto, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.mare);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.water, size:18),),
                          title: Text(AppLocalizations.of(context)!.mare, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectCategory(AppLocalizations.of(context)!.montagna);
                      Navigator.pop(context);           
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(radius:20,child: Icon(FontAwesomeIcons.mountain, size:18),),
                          title: Text(AppLocalizations.of(context)!.montagna, style: Theme.of(context).textTheme.bodyMedium),                          
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(height: 0, color: Theme.of(context).dividerColor,),
                        ),
                      ],
                    ),
                  ),
                ]       
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: showBottomDialog,
          // style: ElevatedButton.styleFrom(
          //     textStyle: const TextStyle(color: Palette.white),
          //     iconColor: Palette.primary,
          //     backgroundColor:Palette.primary,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(6.0), // Small border radius
          //     ),
          //   ),
          child: SizedBox(
            height:55,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.categoria),
                Icon(Icons.chevron_right_outlined, color: Theme.of(context).hintColor,)
              ],
            )),
        ),
        Container(height: 55, color: Theme.of(context).dividerColor, width: 0.5,),   
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: (selectedItem != null)
          ?Text(
            selectedItem!,
            style: const TextStyle(fontSize: 16),
          )
          :Text(
            AppLocalizations.of(context)!.nonSelezionata,
            style: const TextStyle(fontSize: 16),
          )
        ),
      ],
    );
  }
}