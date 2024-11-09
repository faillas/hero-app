// ignore_for_file: must_be_immutable

// import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hero/helpers/validation_manager.dart';
import 'package:hero/palette.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class DateRangeInput extends StatefulWidget {
  DateTimeRange? range;
  String label;
  double? height = 60;
  final Function? onSaveFunction;

  DateRangeInput({super.key, 
    this.range,
    this.label = 'Data inizio - fine',
    required this.onSaveFunction, required int height,
  });

  @override
  State<DateRangeInput> createState() => _DateRangeInputState();
}

class _DateRangeInputState extends State<DateRangeInput> {
  ValidationManager validate = getIt.get<ValidationManager>();
  DateTimeRange? _selectedRange;

  String getInputLabel(){
    String label= widget.label; 
    if(_selectedRange != null){
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String startDate = formatter.format(_selectedRange!.start.toLocal());
      final String endDate = formatter.format(_selectedRange!.end.toLocal());
      label = '$startDate - $endDate';
    }
    return label;
  }

  @override
  void initState() {
    super.initState();
    _selectedRange = widget.range ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 5)),
        );
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final locale = Localizations.localeOf(context);

    // Open the DateRangePicker
    final DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      helpText: AppLocalizations.of(context)!.dataInizioFine,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: locale,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Theme.of(context).primaryColor,
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).highlightColor, // Change the primary color
              onPrimary: Palette.white, // Text color on primary buttons
              surface: Theme.of(context).primaryColor, // Background color of dialog
              onSurface: Theme.of(context).hintColor,
              secondary: Theme.of(context).highlightColor,
              // Text color on surface
            ),
            dialogBackgroundColor: Palette.primary, // Background color of dialog
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ), // Customize the theme
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      // Validate the selected range
      final bool valid = validate.isStartDateBeforeEndDate(
        pickedRange.start,
        pickedRange.end,
      );
      
      if (valid) {
        setState(() {
          _selectedRange = pickedRange;
          widget.onSaveFunction!(_selectedRange); // Pass the selected range to the parent widget
        });
      } else {
        showError('invalid');      
      }
    } else {
      showError('range');
    }
  }

  void showError(String error){
    switch (error) {
      case 'invalid':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Palette.danger,
            content: Text(AppLocalizations.of(context)!.dataFineMaggioreDataInizio),
          ),
        );
        break;
      case 'range':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Palette.danger,
            content: Text(AppLocalizations.of(context)!.dataNonCompresa),
          ),
        );
        break;
      default:
    }
  }

  // Future<void> _pickDateRange(BuildContext context) async {
  //   final locale = Localizations.localeOf(context); 
  //   // Select start date
  //   final DateTime? startDate = await showDatePicker(
  //     context: context,
  //     helpText:AppLocalizations.of(context)!.dataDiInizio,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //     barrierColor: Theme.of(context).primaryColor,
  //     locale: locale
  //   );

  //   if (startDate == null){
  //     ScaffoldMessenger.of(context).showSnackBar(
  //        SnackBar(
  //         backgroundColor: Palette.danger,
  //         content: Text(AppLocalizations.of(context)!.dataFineMaggioreDataInizio),
  //       ),
  //     );
  //     return;
  //   }

  //   final DateTime? endDate = await showDatePicker(
  //     context: context,
  //     helpText:AppLocalizations.of(context)!.dataDiFine,
  //     firstDate: startDate,
  //     lastDate: DateTime(2100),
  //     barrierColor: Theme.of(context).primaryColor,
  //     locale: locale
  //   );

  //   if (endDate == null){
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Palette.danger,
  //         content: Text(AppLocalizations.of(context)!.dataFineMaggioreDataInizio),
  //       ),
  //     );
  //     return;
  //   }

  //   // validation
  //   final valid = validate.isStartDateBeforeEndDate(startDate, endDate);
  //   if(valid== true){
  //     // Update the range and pass it to the parent widget
  //     setState(() {
  //       _selectedRange = DateTimeRange(start: startDate, end: endDate);
  //       widget.onSaveFunction!(_selectedRange);
  //     });
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Palette.danger,
  //         content: Text(AppLocalizations.of(context)!.dataFineMaggioreDataInizio),
  //       ),
  //     );
  //   }   
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDateRange(context),
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getInputLabel(),
              style: const TextStyle(fontSize: 16),
            ),
            Icon(Icons.date_range, color: Theme.of(context).dividerColor,),
          ],
        ),
      ),
    );
  }
}
