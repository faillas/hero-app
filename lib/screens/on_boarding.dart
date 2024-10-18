import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/services/config_service.dart';
import 'package:hero/widgets/select_theme.dart';
import '../palette.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt getIt = GetIt.instance;

class OnBoarding extends StatefulWidget {
  final VoidCallback onComplete;
  const OnBoarding({required this.onComplete, super.key});
  static const routeName = '/welcome';

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> with SingleTickerProviderStateMixin{
  final introKey = GlobalKey<IntroductionScreenState>();
  late ConfigService configservice  = getIt.get<ConfigService>();

  @override
  Widget build(BuildContext context) {  
    return IntroductionScreen(
        showNextButton:false,
        showBackButton:false,
        showDoneButton : false,
        key: introKey,
        controlsPadding : const EdgeInsets.all(1.0),
        skipStyle: ButtonStyle(
            textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 17)),
            foregroundColor: WidgetStateProperty.all(Palette.primary)),
        allowImplicitScrolling: true,
        autoScrollDuration: 300000000,
        infiniteAutoScroll: false,
        globalBackgroundColor:Colors.white,
        controlsMargin: const EdgeInsets.all(1),
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.benvenutoIn, style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black
                  ),),
                  Image.asset('assets/logo-light.png', height: 60),
                  const SizedBox(height: 30,),
                  Image.asset('assets/icons/animated/wave.gif', height: 120)
                  
                ],
              ),
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                     Text(AppLocalizations.of(context)!.scegliTemaApp, textAlign: TextAlign.center, style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black
                      ),),
                      Text(AppLocalizations.of(context)!.potraiModificarloInSeguito, style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black
                      ),),
                      const SizedBox(height: 100,),
                       const SizedBox(
                        height: 225,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SelectTheme(),
                        ),
                      )
                    ],
                  ),               
                ],
              ),
          ),    
          PageViewModel(
            title: "",
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [                
                   Text(AppLocalizations.of(context)!.oraPuoiIniziare, textAlign: TextAlign.center, style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black
                    ),),
                    const SizedBox(height: 30,),
                    Image.asset('assets/icons/animated/award.gif', height: 120),
                   Center(
                    child: ElevatedButton(
                        onPressed: () {
                          configservice.updateConfig(1, 0);
                          widget.onComplete();                     
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 6,
                          backgroundColor: Palette.primary, 
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))// Background color
                        ),
                        child: Text(AppLocalizations.of(context)!.conferma, style: const TextStyle(color: Colors.white),),
                      ),
                   )
                 
                ],
              ),
            ),
          ),
        ],
        freeze: false,
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(
          Icons.arrow_forward,
          color: Palette.info,
        ),
        nextStyle: ButtonStyle(
          foregroundColor:
            WidgetStateProperty.all(const Color.fromARGB(255, 248, 64, 64))),
        dotsDecorator: const DotsDecorator(
          size: Size.square(10),
          activeColor: Palette.primary,
          activeSize: Size.square(17),
        ),
      );     
  }
}
