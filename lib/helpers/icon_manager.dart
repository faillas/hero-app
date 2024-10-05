
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconManager {

  Icon getIconFromLabel(String? label) {
    switch (label) {
      case 'Informazioni':
        return const Icon(FontAwesomeIcons.infoCircle, size:18);
      case 'Pagamento':
        return const Icon(FontAwesomeIcons.coins, size:18);
      case 'Volo':
        return const Icon(FontAwesomeIcons.plane, size:18);
      case 'Albergo':
        return const Icon(FontAwesomeIcons.conciergeBell, size:18);
      case 'Museo':
        return const Icon(FontAwesomeIcons.landmark, size:18);
      case 'Autobus':
        return const Icon(FontAwesomeIcons.bus, size:18);
      case 'Metro':
        return const Icon(FontAwesomeIcons.train, size:18);
      case 'Taxi':
        return const Icon(FontAwesomeIcons.taxi, size:18);
      case 'Auto':
        return const Icon(FontAwesomeIcons.car, size:18);
      case 'Speciale':
        return const Icon(FontAwesomeIcons.star, size:18);
      case 'Pasto':
        return const Icon(FontAwesomeIcons.pizzaSlice, size:18);
      case 'Mare':
        return const Icon(FontAwesomeIcons.water, size:18);
      case 'Montagna':
        return const Icon(FontAwesomeIcons.mountain, size:18);
      default: return const Icon(FontAwesomeIcons.infoCircle, size:18);
    }
  }

  
}
