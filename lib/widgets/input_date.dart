import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputDate extends StatefulWidget {
  final Function? onSaveFunction;
  const InputDate({super.key, required this.onSaveFunction});

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    widget.onSaveFunction!(pickedDate);
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
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
              _selectedDate == null
                  ? AppLocalizations.of(context)!.data
                  : DateFormat.yMMMd().format(_selectedDate!),
              style: TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
            ),
          ),
        ),

        
        
      ],
    );
  }
}