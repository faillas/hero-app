import 'package:flutter/material.dart';
import 'package:hero/helpers/validation_manager.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class InputDate extends StatefulWidget {
  final String start;
  final String end;
  final Function? onSaveFunction;
  final Function? onError;
  const InputDate({super.key,required this.start, required this.end, required this.onSaveFunction, required this.onError});

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  ValidationManager validate = getIt.get<ValidationManager>();
  DateTime? _selectedDate;

  String getInputLabel(context){
    String label= AppLocalizations.of(context)!.data; 
    if(_selectedDate != null){
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      label = formatter.format(_selectedDate!.toLocal());
    }
    return label;
  }

  Future<void> _selectDate(BuildContext context) async {
    final locale = Localizations.localeOf(context); 
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      helpText:AppLocalizations.of(context)!.data,
      barrierColor: Theme.of(context).primaryColor,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: locale
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      final valid = validate.isDateInRange(widget.start, widget.end, pickedDate);
      if(valid == true){
        setState(() {
          _selectedDate = pickedDate;
        });
        widget.onSaveFunction!(pickedDate);
      }else{
        _selectedDate = null;
        setState(() {});
        widget.onError!();
      }
    }else{
      _selectedDate = null;
      setState(() {});
      widget.onError!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.only(bottom: 0.5), // Padding for spacing
          
          child: TextButton(
            style:const ButtonStyle(alignment: Alignment.centerLeft),
            onPressed: () =>_selectDate(context),
            child: Text(
              getInputLabel(context),
              style: TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
            ),
          ),
        ),

        
        
      ],
    );
  }
}

