import 'package:flutter/material.dart';
import 'package:test_drive/palette.dart';
import 'package:test_drive/screens/full_screen_image.dart';
import 'package:test_drive/widgets/cover_travel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Gallery extends StatelessWidget {
  final List<dynamic> travels;
  const Gallery({required this.travels, super.key});
  static const routeName = '/gallery';

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: travels.length, // Number of images
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            if(travels[index].image != null){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                    image: travels[index].image,
                    title: travels[index].name
                  ),
                ),
              );
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  backgroundColor: Palette.danger,
                  content: Text(AppLocalizations.of(context)!.immagineNonDisponibile),
                ),
              );
            }
          },
          child: CoverTravel(
            detail: true,
            cover: travels[index].image,
            travel: travels[index].name,
            onSaveFunction: null,
          ),
        );
      },
    );             
  }
}
