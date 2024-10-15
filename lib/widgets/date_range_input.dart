// ignore_for_file: must_be_immutable

// import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  DateTimeRange? _selectedRange;

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
    // Select start date
    final DateTime? startDate = await showDatePicker(
      context: context,
      helpText:AppLocalizations.of(context)!.dataDiInizio,
      initialDate: _selectedRange!.start,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      barrierColor: Theme.of(context).primaryColor,
      locale: locale
    );

    if (startDate == null) return;

    // Select end date after start date is picked
    final DateTime? endDate = await showDatePicker(
      context: context,
      helpText:AppLocalizations.of(context)!.dataDiFine,
      initialDate: _selectedRange!.end,
      firstDate: startDate,
      lastDate: DateTime(2100),
      barrierColor: Theme.of(context).primaryColor,
      locale: locale
    );

    if (endDate == null) return;

    // Update the range and pass it to the parent widget
    setState(() {
      _selectedRange = DateTimeRange(start: startDate, end: endDate);
      widget.onSaveFunction!(_selectedRange);
    });
  }

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
              _selectedRange == null
                  ? widget.label
                  : '${_selectedRange!.start.toLocal().toString().split(' ')[0]} - ${_selectedRange!.end.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            Icon(Icons.date_range, color: Theme.of(context).dividerColor,),
          ],
        ),
      ),
    );
    // DateRangeField(
    //     enabled: true,
    //     initialValue: (widget.range != null)
    //       ? widget.range
    //       : DateTimeRange(
    //           start: DateTime.now(),
    //           end: DateTime.now().add(const Duration(days: 5))),
    //       decoration: InputDecoration(
          
    //       labelText: widget.label,
    //       // prefixIcon: Container(width:30,child: const Icon(Icons.date_range)),
    //       hintText: 'Please select a start and end date',
    //       border:  OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(8),
    //         borderSide: const BorderSide(
    //             width: 0, 
    //             style: BorderStyle.none,
    //         ),
    //       ),
    //       contentPadding: const EdgeInsets.all(0),
    //       focusedBorder: const UnderlineInputBorder(),     
    //     ),
    //     validator: (value) {
    //       return null;
    
    //       // if (value!.start.isBefore(DateTime.now())) {
    //       //   return 'Please enter a later start date';
    //       // }
    //       // return null;
    //     },
    //     // onSaved: (value) {
    //     //   widget.onSaveFunction!(value);
    //     //   setState(() {
    //     //     widget.range = value;
    //     //   });
    //     // },
    //     onChanged: (value) {
    //       widget.onSaveFunction!(value);
    //       setState(() {
    //         widget.range = value;
    //       });
    //     },
        
    //   );
  }
}
