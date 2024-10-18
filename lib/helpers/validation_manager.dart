import 'package:test_drive/models/budget.dart';
import 'package:test_drive/models/note.dart';
import 'package:test_drive/models/plan.dart';
import 'package:test_drive/models/travel.dart';
import 'package:test_drive/models/wish_item.dart';

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

  bool isStartDateBeforeEndDate(DateTime dateStart, DateTime dateEnd) {
    return dateStart.isBefore(dateEnd);
  }

  bool isDateInRange(DateTime dateStart, DateTime dateEnd, DateTime date) {
    return (
      date.isAtSameMomentAs(dateStart) ||
      date.isAfter(dateStart)) && (date.isAtSameMomentAs(dateEnd) || date.isBefore(dateEnd)
    );
  }

}
