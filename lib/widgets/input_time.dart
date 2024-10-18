import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputTime extends StatefulWidget {
  final Function? onSaveFunction;

  const InputTime({required this.onSaveFunction, super.key});

  @override
  State<InputTime> createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> {
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      barrierColor: Theme.of(context).primaryColor,
      helpText:AppLocalizations.of(context)!.tempo,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });

       // Convert TimeOfDay to HH:mm format
      final localizations = MaterialLocalizations.of(context);
      final String formattedTime = localizations.formatTimeOfDay(pickedTime, alwaysUse24HourFormat: true);

      // Send the formatted time string to the onSaveFunction
      widget.onSaveFunction?.call(formattedTime);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 0.5), // Padding for spacing
          
          child: TextButton(
            style:const ButtonStyle(alignment: Alignment.centerLeft),
            onPressed: () => _selectTime(context),
            child: Text(
              textAlign: TextAlign.start,
              _selectedTime == null
                  ? AppLocalizations.of(context)!.orario
                  : _selectedTime!.format(context),
              style: TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
            ),
          ),
        ),
        
      ],
    );
  
  }
}
