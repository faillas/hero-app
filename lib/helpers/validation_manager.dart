import 'package:hero/models/budget.dart';
import 'package:hero/models/note.dart';
import 'package:hero/models/plan.dart';
import 'package:hero/models/travel.dart';
import 'package:hero/models/wish_item.dart';

class ValidationManager {

  bool travelValidation(Travel travel) {
    //validate logics
    if(travel.dateStart.isNotEmpty && travel.dateEnd.isNotEmpty && travel.name.isNotEmpty){
      return true;
    }
    //show snackbar
    return false;
  }

  bool planValidation(Plan plan) {
    //validate logics
    if(plan.description.isNotEmpty && plan.hourStart.isNotEmpty){
      return true;
    }
    //show snackbar
    return false;
  }

  bool budgetValidation(Budget budget) {
    //validate logics
    if(budget.value.isNotEmpty && budget.name.isNotEmpty){
      return true;
    }
    //show snackbar
    return false;
  }

  bool wishlistValidation(WishItem item) {
    //validate logics
    if(item.description.isNotEmpty){
      return true;
    }
    //show snackbar
    return false;
  }

  bool notesValidation(Note note) {
    //validate logics
    if(note.description.isNotEmpty){
      return true;
    }
    //show snackbar
    return false;
  }

}
