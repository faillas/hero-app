# Hero App

Applicazione per i viaggi con le seguenti funzionalità:

* registrare viaggi con relative spese e pianificazioni giorno per giorno
* vedere i viaggi registrati in una bacheca, in una timeline e in una galleria di immagini
* registrare note
* registrare lista di cose da fare
* vedere statistiche sui viaggi

> da valutare anche il diario di viaggio con scrittura a mano

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Icona app del launcher

Il file di configurazione si trova nella root ed è denominato `flutter_launcher_icons.yaml`. 
Modificarlo e lanciare i seguenti comandi per caricare una nuova immagine per il launcher:

```
flutter pub get
flutter pub run flutter_launcher_icons -f <your config file name here>
```

## apk per device in locale

```
flutter clean
flutter pub get
flutter build apk --release
flutter install
```

## TO-DO LIST

* dates range input validations
* theme management
* refactoring test_drive ---> hero
* recheck landing page
* messa in produzione

## Traduzioni

Le traduzioni sono gestite con la libreria [flutter localization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) in 5 lingue:

* italiano
* inglese
* francese
* spagnolo 
* tedesco

i file sono nella cartella I10n. i componenti che necessitano di traduzioni hanno bisogno del seguente import:

```
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

e della seguente struttura per la traduzione delle stringhe:

```
AppLocalizations.of(context)!.<termine>
```

i file con i dizionari vengono generati automaticamente una volta impostato il file main.dart e attivata la modalità debug del progetto.
